import os
import sys
import argparse
import subprocess


def main_args():
    parser = argparse.ArgumentParser()

    commands = parser.add_subparsers(dest='command')
    commands.add_parser('parent-dirs')
    commands.add_parser('parent-files')
    commands.add_parser('content-dirs')
    commands.add_parser('content-files')

    args = parser.parse_args(sys.argv[1:])
    return args, parser


def main(args, parser):
    if args.command == 'parent-dirs':
        DirOps.list_parent_dirs()
    elif args.command == 'parent-files':
        DirOps.list_parent_files()
    elif args.command == 'content-dirs':
        DirOps.list_content_dirs()
    elif args.command == 'content-files':
        DirOps.list_content_files()
    else:
        parser.print_help()


class DirOps:
    @classmethod
    def exclude_common(cls, patha, pathb):
        return pathb.replace(cls.designate_dir(patha), "")

    @staticmethod
    def designate_dir(path):
        if os.path.isdir(path) and path != '/':
            path = '{}/'.format(path)
        return '{}'.format(path)

    @classmethod
    def format_path(cls, path):
        return '"{}"'.format(cls.designate_dir(path))

    @staticmethod
    def find(dir, args):
        find_args = ['find', dir]
        find_args.extend(args)
        out = subprocess.Popen(find_args, stdout=subprocess.PIPE)
        out.wait()
        out_dirs = []
        for line in out.stdout.readlines():
            line = line.strip()
            out_dirs.append(line)
        return out_dirs

    @classmethod
    def list_parent_dirs(cls):
        cwd = os.getcwd()
        cur_dir = cwd
        dir_list = list()
        while True:
            cur_dir_parent = os.path.dirname(cur_dir)
            if cur_dir == cur_dir_parent:
                break
            dir_list.append(cur_dir_parent)
            cur_dir = cur_dir_parent

        for dir in dir_list:
            print(cls.format_path(dir))

    @classmethod
    def list_parent_files(cls):
        cwd = os.getcwd()
        cur_dir = cwd
        dir_list = list()
        while True:
            cur_dir_parent = os.path.dirname(cur_dir)
            if cur_dir == cur_dir_parent:
                break
            dir_list.append(cur_dir_parent)
            cur_dir = cur_dir_parent

        for dir in dir_list:
            pfiles = cls.find(dir, ['-maxdepth', '1'])
            for file in pfiles:
                print(cls.format_path(file))

    @classmethod
    def list_content_dirs(cls):
        cwd = os.getcwd()
        dirs = cls.find(cwd, [
            # Exclude Git Folders
            '-path', '*/.git/*', '-path', '*/.git',

            # Prune Path
            '-prune', '-o', '-type', 'd', '-print',
        ])

        for dir in dirs:
            if dir == cwd:
                continue
            print(cls.exclude_common(cwd, cls.format_path(dir)))

    @classmethod
    def list_content_files(cls):
        cwd = os.getcwd()
        files = cls.find(cwd, [
            # Exclude Git Folders
            '-path', '*/.git/*', '-path', '*/.git',

            # Prune Path
            '-prune', '-o', '-type', 'f', '-print',
        ])
        for file in files:
            print(cls.exclude_common(cwd, cls.format_path(file)))


if __name__ == '__main__':
    main(*main_args())

