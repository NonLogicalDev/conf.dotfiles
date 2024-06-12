#!/bin/bash

if command -v nvim /dev/null 2>&1; then
	nvim "$@"
elif command -v vim /dev/null 2>&1; then
	vim "$@"
elif command -v nano /dev/null 2>&1; then
	nano "$@"
else
	ed "$@"
fi
