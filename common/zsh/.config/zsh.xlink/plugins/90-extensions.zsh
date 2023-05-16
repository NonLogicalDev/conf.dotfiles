__this_file="${0:a}"

function exists { which $1 &> /dev/null }

# function funcs-help()  {
#     cat "$__this_file" | awk '
#         BEGIN { _comment = "" }
#         /^#\> / { if (length(_comment) > 0) _comment = _comment "\n" $0; else _comment = $0; }
#         /^function / { if (length(_comment) > 0) { print "\n" _comment;  } _comment = "" }
#     '
# }

#> lspath: print all components of the path
function lspath() {
    for p in $path; do
        echo $p
    done
}

#-------------------------------------------------------------------------------

#> cpd: copy dir to target, ensuring target hierarchy exists
#>  cpd [srcs...] [DST]
function cpd() {
  if [[ ${#*[@]} -le 1 ]]; then
    echo "Usage: [srcs...] [DST]"
    exit 1
  fi
  local target="${@[-1]}"
  local target_dir=$(dirname "$target")
  if [[ ! -a $dst ]]; then
    mkdir -p $target_dir
  fi
  cp "$@"
}

if (( $+commands[fzf] )); then
  function cdu { # mnemonic: cd-up -- go to parent dir
    cd "$(ls-parents | fzf)"
  }
fi

if (( $+commands[tree] )); then
  function lst() { # mnemonic: ls-tree -- list current dir as a tree 2 levels deep.
    tree -L 2 -C $* | less
  }
fi

#-------------------------------------------------------------------------------

alias grepb='grep --line-buffered'

alias cdb='cd "+1"'
if (( $+commands[realpath] )); then
  alias cdr='cd "$(realpath .)"'
else
  alias cdr=':'
fi

alias tpaste='tmux saveb - | pbpaste'
alias tcopy='tmux show-buffer | pbcopy'


if (( $+commands[docker] )); then
  function drun() {
    local PRE_ARGS=()
    local ARGS=()
    while [[ $# -gt 0 ]]; do
      if [[ $1 == '--here' ]]; then
        PRE_ARGS+=(
          "-v" "$(pwd):/srv/mnt"
          "-w" "/srv/mnt"
        )
        shift
      else
        ARGS+=($1)
        shift
      fi
    done
    docker run --rm -ti "${PRE_ARGS[@]}" "${ARGS[@]}"
  }
  function dexec() {
    docker exec -ti "$@"
  }
fi

#-------------------------------------------------------------------------------

# macOS Everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'

  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
elif [[ "$OSTYPE" == linux* ]]; then
  __open_cmd() {
    xdg-open "$@" 1> /dev/null 2> /dev/null & disown
  }
  alias o='__open_cmd'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  fi

  if (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi

  if (( $+commands[wl-copy] )); then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  fi
fi

#-------------------------------------------------------------------------------

sman() {
  local MAXMANWIDTH=120
  if [[ $COLUMNS -gt $MAXMANWIDTH ]]; then
    MANWIDTH=$MAXMANWIDTH man "$@"
  else
    man "$@"
  fi
}

alias man="sman"
compdef sman="man"

#-------------------------------------------------------------------------------

# Resource Usage
alias df='df -kh'
alias du='du -kh'

if [[ "$OSTYPE" == (darwin*|*bsd*) ]]; then
  alias topc='top -o cpu'
  alias topm='top -o vsize'
else
  alias topc='top -o %CPU'
  alias topm='top -o %MEM'
fi

#-------------------------------------------------------------------------------

# Makes a directory and changes to it.
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
  builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pops an entry off the directory stack and lists its contents.
function popdls {
  builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

#-------------------------------------------------------------------------------

# Prints columns 1 2 3 ... n.
function slit {
  awk "{ print ${(j:,:):-\$${^@}} }"
}

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
  ps -U "${1:-$LOGNAME}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

#-------------------------------------------------------------------------------

# Simple Gitignore Generator
function gi() {
    curl -L -s https://www.gitignore.io/api/$@
}

# Create a git.io short URL
function gitio() {
    if [ -z "${1}" -o -z "${2}" ]; then
        echo "Usage: \`gitio slug url\`";
        return 1;
    fi;
    curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

#-------------------------------------------------------------------------------

# `lk` lists the link location.
function lk {
  if [[ -d  "$1" ]]; then
    ls -al "$1"
  fi
}

# `wanip` returns the current ip as seen from the internet.
function wanip {
  dig @resolver1.opendns.com ANY myip.opendns.com +short
}

# `ps-parents` prints recursively the parents of the current shell.
function ps-parents {
 pid=$$
 while true; do
   ps -p $pid -o 'pid= command=' || break
   pid=$(ps -p $pid -o 'ppid=')
 done
}

# `refresh cmd` executes clears the terminal and prints
# the output of `cmd` in it.
function refresh {
  tput clear || exit 2; # Clear screen. Almost same as echo -en '\033[2J';
  zsh -ic "$@";
}

# `botch` executes clears the terminal and prints repeatedly
# like a watch command
function botch() {
    TIME=$1
    shift 1
    while true; do
        (echo -en '\033[H'
            CMD="$@"
            bash -c "$CMD" | while read LINE; do
                echo -n "$LINE"
                echo -e '\033[0K'
            done
            echo -en '\033[J')
        sleep $TIME
    done
}

# Like watch, but with color
function cwatch {
   while true; do
     CMD="$@";
     # Cache output to prevent flicker. Assigning to variable
     # also removes trailing newline.
     output=`refresh "$CMD"`;
     # Exit if ^C was pressed while command was executing or there was an error.
     exitcode=$?; [ $exitcode -ne 0 ] && exit $exitcode
     printf '%s' "$output";  # Almost the same as echo $output
     sleep 1;
   done
}

# `ls-parents` prints recursively the parent directories.
function ls-parents() {
  local p="$(pwd)"
  while [[ $p != '/' ]]; do
    echo $p
    p="$(dirname $p)"
  done
}

# Simple calculator
function calc() {
    local result="";
    result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
    #                       └─ default (when `--mathlib` is used) is 20
    #
    if [[ "$result" == *.* ]]; then
        # improve the output for decimal numbers
        printf "$result" |
        sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
            -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
            -e 's/0*$//;s/\.$//';  # remove trailing zeros
    else
        printf "$result";
    fi;
    printf "\n";
}

# `mkd` created a new directory and enters it.
function mkd() {
    mkdir -p "$@" && cd "$@";
}

if [[ "$OSTYPE" == darwin* ]]; then
    # Change working directory to the top-most Finder window location
    function cdf() { # short for `cdfinder`
        cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
    }
fi

# `targz` Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
    local tmpFile="${@%/}.tar";
    tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

    size=$(
        stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
        stat -c"%s" "${tmpFile}" 2> /dev/null  # GNU `stat`
    );

    local cmd="";
    if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
        # the .tar file is smaller than 50 MB and Zopfli is available; use it
        cmd="zopfli";
    else
        if hash pigz 2> /dev/null; then
            cmd="pigz";
        else
            cmd="gzip";
        fi;
    fi;

    echo "Compressing .tar using \`${cmd}\`…";
    "${cmd}" -v "${tmpFile}" || return 1;
    [ -f "${tmpFile}" ] && rm "${tmpFile}";
    echo "${tmpFile}.gz created successfully.";
}

# `fs` Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* *;
    fi;
}

# Use Git’s colored diff when available
if (( $+commands[colordiff] )); then
    function cdiff() {
        "$commands[diff]" -Naur "$@" | colordiff;
    }
elif exists git; then
    function cdiff() {
        git diff --no-index --color-words "$@";
    }
fi

#--------------------------------------------------------------------------------

# UTF-8-encode a string of Unicode symbols
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Get a character’s Unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

#--------------------------------------------------------------------------------

# Create a data URL from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1");
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8";
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}";
    sleep 1 && open "http://localhost:${port}/" &
    python3 -m http.server "$port"
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
    local port="${1:-4000}";
    sleep 1 && open "http://localhost:${port}/" &
    php -S "localhost:${port}";
}

# Run `dig` and display the most useful info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer;
}

#--------------------------------------------------------------------------------

# Compare original and gzipped file size
function gz-compare() {
    local origsize=$(wc -c < "$1");
    local gzipsize=$(gzip -c "$1" | wc -c);
    local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l);
    printf "orig: %d bytes\n" "$origsize";
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio";
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified.";
        return 1;
    fi;

    local domain="${1}";
    echo "Testing ${domain}…";
    echo ""; # newline

    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
        | openssl s_client -connect "${domain}:443" 2>&1);

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_header, no_serial, no_version, \
            no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
            echo "Common Name:";
            echo ""; # newline
            echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
            echo ""; # newline
            echo "Subject Alternative Name(s):";
            echo ""; # newline
            echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
                | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
            return 0;
    else
        echo "ERROR: Certificate not found.";
        return 1;
    fi;
}
