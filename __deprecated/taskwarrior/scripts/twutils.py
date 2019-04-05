#!/usr/bin/env python

import json
import os
import sys
import argparse
import subprocess as sp
import re


_find_unsafe = re.compile(r'[a-zA-Z0-9_^@%+=:,./-]').search

def quote(s):
    """Return a shell-escaped version of the string *s*."""
    if not s:
        return "''"

    if _find_unsafe(s) is None:
        return s

    # use single quotes, and put single quotes into double quotes
    # the string $'b is then quoted as '$'"'"'b'

    return "'" + s.replace("'", "'\"'\"'") + "'"


def tsw2tiw_id(twid):
    return "[{}]".format(twid)


def tsw2tiw_annotation(new):
    # Hook should extract all of the following for use as Timewarrior tags:
    #   UUID
    #   Project
    #   Tags
    #   Description
    #   UDAs

    twid = new['uuid']

    tags = [
        tsw2tiw_id(twid),
        "({})".format(new['description'])
    ]

    if 'project' in new:
        project = new['project']
        tags.append("#{}".format(project))

    if 'phabref' in new:
        phabref = new['phabref']
        tags.append(":{}".format(phabref))

    if 'tags' in new:
        tags.extend(["+{}".format(tag) for tag in new['tags']])

    #combined = (sorted(['"%s"' % tag for tag in tags])).encode('utf-8').strip()
    combined = sorted(map(lambda s: s.strip(), tags))
    return twid, combined


def tiw_cmd_start(tags):
    cmd = 'tw.time start {tags} :yes'.format(**{
        "tags": " ".join(map(quote, tags))
    })
    os.system(cmd)


def tiw_cmd_stop(tags):
    cmd = 'tw.time stop {tags} :yes'.format(**{
        "tags": " ".join(map(quote, tags))
    })
    os.system(cmd)


def tiw_track(tags, time_exp):
    cmd = 'tw.time track {time} {tags} :yes :adjust'.format(**{
        "time": time_exp,
        "tags": " ".join(map(quote, tags))
    })
    os.system(cmd)


def tsw_export(idx):
    cmd = 'tw.task export {id} rc.json.array=off'.format(**{
        "id": idx
    })
    _in, _out, _err = os.popen3(cmd)
    return _out.read()


def tsw_onmodify():
    # Make no changes to the task, simply observe.
    old = json.loads(sys.stdin.readline())
    new = json.loads(sys.stdin.readline())
    twid, combined = tsw2tiw_annotation(new)

    if 'start' in new and not 'start' in old:
        # Started task.
        tiw_cmd_start(combined)

    elif not 'start' in new and 'start' in old:
        # Stopped task.
        tiw_cmd_stop([tsw2tiw_annotation(twid)])

    elif 'start' in new and new['status'] != 'pending':
        # Any task that is active, with a non-pending status should not be tracked.
        tiw_cmd_stop(combined)

    print(json.dumps(new))


def main():
    p = argparse.ArgumentParser()
    csp = p.add_subparsers(dest="cmd")

    csp.add_parser("ts2ti")
    
    cmd_track = csp.add_parser("track", help="track this task in timewarrior")
    cmd_track.add_argument("twid", type=int)
    cmd_track.add_argument("time_exp", nargs="+")

    args = p.parse_args()

    if args.cmd == 'ts2ti':
        input = sys.stdin.read()
        new = json.loads(input)
        if isinstance(new, list):
            new = dict(enumerate(new)).get(0, None)
        if new:
            id, new_str = tsw2tiw_annotation(new)
            print(" ".join(new_str))
    elif args.cmd == 'track':
        print(tsw_export(args.twid))
        #tiw_track()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass
