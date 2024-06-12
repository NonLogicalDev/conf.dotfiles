#!/bin/bash
AS_PREVIEW=0
if [[ $1 == "--as-preview" ]]; then
	shift
	AS_PREVIEW=1
fi

if [[ AS_PREVIEW -eq 1 ]] && command -v qlmanage >/dev/null 2>&1; then
	qlmanage -p "$@" &
elif command -v open >/dev/null 2>&1; then
	open "$@"
elif command -v xdg-open >/dev/null 2>&1; then
	xdg-open "$@"
else
	echo >&2 "No Open command exists (open, xdg-open) can not open"
fi
