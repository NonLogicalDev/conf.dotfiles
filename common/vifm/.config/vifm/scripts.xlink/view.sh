#!/bin/bash
has_command() {
	command -v "$1" >/dev/null 2>&1
}

has_function() {
	declare -F "$1" >/dev/null
}

safe_file_info() {
	if has_command file; then
		file "$1"
	else
		echo "unknown"
	fi
}

guess_file() {
	FILE_INFO=$(safe_file_info $1)

	case "$FILE_INFO" in
		*text*)
			echo "text"; return
			;;
		*directory*)
			echo "dir"; return
			;;
		*zip*archive*)
			echo "zip"; return
			;;
	esac
	case "$1" in
		*.zip)
			echo "zip"
			;;
		*.tar)
			echo "tar"
			;;
		*.tar.gz)
			echo "tar_gz"
			;;
		*)
			echo "generic"
	esac
}

view_generic() {
	ls -al $1
}

view_text() {
	cat "$1"
}

view_dir() {
	if has_command tree; then
		tree -C -L 1 "$1"
	else
		ls "$1"/*
	fi
}

view_zip() {
	if has_command unzip; then
		unzip -vl "$1"
	fi
}

view_tar() {
	if has_command tar; then
		tar --list -f "$1"
	fi
}

view_tar_gz() {
	if has_command tar; then
		tar --list -zf "$1"
	fi
}

VIEW_FN="view_generic"
TYPE="generic"
if [[ $1 == "--type" ]]; then
	if declare -F "view_$2" >/dev/null; then
		TYPE="$2"
		VIEW_FN="view_$2"
	fi
	shift 2
fi
if [[ $TYPE == "generic" ]]; then
	TYPE=$(guess_file $1)
	VIEW_FN="view_$TYPE"
fi

echo ":: PATH($1)"
echo ":: TYPE($TYPE)"
if has_command file; then
echo ":: INFO :: $(file "$1")"
fi
echo
"$VIEW_FN" "$1"