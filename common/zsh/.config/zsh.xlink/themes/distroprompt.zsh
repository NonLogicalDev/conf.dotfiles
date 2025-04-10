# Distroprompt for ZSH
# By mjturt
# Nerdfonts patched font required (https://github.com/ryanoasis/nerd-fonts)
# Based on Karu prompt theme by zaari

# Current working directory
distroprompt_dir() {
   if [[ "$(pwd)" != "$HOME" ]] ; then
      echo -n "%."
   fi
}

# OS symbol
distroprompt_os_symbol() {
   # Root
   if [[ $EUID == 0 ]] ; then
      echo -n "%B%F{228}"
   else
      stat_ret=( $(stat -Lc "%a %G %U" "`pwd`") )
      local stat_perm=${stat_ret[1]}
      local stat_owner=${stat_ret[3]}

      if [[ $(( $stat_perm[-1] & 2 )) != 0 ]] || [[ $stat_owner == $USER ]]; then
         # OS test
         case $(uname) in
         "Linux")
            if [ $(grep "Gentoo" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{212}"
            elif [ $(grep "Arch" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{033}"
            elif [ $(grep "Debian" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{052}"
            elif [ $(grep "Slackware" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{060}"
            elif [ $(grep "Ubuntu" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{166}"
            elif [ $(grep "Mint" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{040}"
            elif [ $(grep "suse" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{002}"
            elif [ $(grep "RHEL" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{088}"
            elif [ $(grep "Fedora" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{027}"
            elif [ $(grep "CentOS" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{154}"
            elif [ $(grep "Elementary" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{253}"
            elif [ $(grep "NixOS" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{074}"
            elif [ $(grep "Manjaro" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{040}"
            elif [ $(grep "Alpine" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{025}"
            elif [ $(grep "Devuan" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{059}"
            elif [ $(grep "Mageia" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{025}"
            elif [ $(grep "Sabayon" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{252}"
            elif [ $(grep "Raspbian" /etc/*-release | wc -l) -gt "0" ]
            then
               echo -n "%B%F{125}"
            else
               # Distro cant be determined
               echo -n "%B%F{253}" 
            fi
         ;;
         "FreeBSD")
            echo -n "%B%F{088}"
         ;;
         "Darwin")
            echo -n "%B%F{250}"
         ;;
         "WindowsNT")
            echo -n "%B%F{033}"
         esac
      else
         # If cant write
         echo -n "%B%F{203}"
      fi
   fi
}

# Status symbol
distroprompt_status_symbol() {
   echo -n " "
}

distroprompt_git_info() {
   # HEAD test and branch name
   local ref
   ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
   local ret=$?
   if [[ $ret != 0 ]]; then
      [[ $ret == 128 ]] && return
      ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
   fi
   local current_branch="${ref#refs/heads/}"

   # Ahead, behind and dirtyness tests
   if [[ -n "$(command git rev-list origin/${current_branch}..HEAD 2> /dev/null)" ]]; then
      echo -n "$DISTROPROMPT_GIT_AHEAD"
   elif [[ -n "$(command git rev-list HEAD..origin/${current_branch} 2> /dev/null)" ]]; then
      echo -n "$DISTROPROMPT_GIT_BEHIND"
   else
      git diff-index --quiet HEAD -- 2>/dev/null
      if [[ $? -ne 0 ]] ; then
         echo -n "$DISTROPROMPT_GIT_DIRTY"
      else
         if [[ "$DISTROPROMPT_SHOW_DIR" == "right" ]] ; then
            echo -n "$DISTROPROMPT_GIT_CLEAN"
         fi 
      fi
   fi

   # Branch name
   echo "${current_branch} "
}

# Executed before each prompt
precmd() {
   local distroprompt_exit_color="%(?.${DISTROPROMPT_NOERROR_COLOR}.${DISTROPROMPT_ERROR_COLOR})"  

   # Update terminal title
   print -Pn "\e]0;%n@%m:%/\a"  

   # Directory name placement
   if [[ "$DISTROPROMPT_SHOW_DIR" == "left" ]] ; then
      local dir_left="$(distroprompt_dir)"
   elif [[ "$DISTROPROMPT_SHOW_DIR" == "right" ]] ; then
      local dir_right="$(distroprompt_dir)"
   fi

   # Main prompt (PS1)
   PROMPT="${DISTROPROMPT_LEFT_PROMPT_COLOR}${dir_left}$(distroprompt_os_symbol)${distroprompt_exit_color} ($CONTAINER_ID)$(distroprompt_status_symbol) %b%f"

   # Right prompt
   RPROMPT="${DISTROPROMPT_RIGHT_PROMPT_COLOR}${dir_right}$(distroprompt_git_info)%b%f"
}

# Git symbols
DISTROPROMPT_GIT_DIRTY=" × "
DISTROPROMPT_GIT_CLEAN="  "
DISTROPROMPT_GIT_AHEAD="  "
DISTROPROMPT_GIT_BEHIND="  "

# Colors
DISTROPROMPT_LEFT_PROMPT_COLOR="%B%F{212}"
DISTROPROMPT_RIGHT_PROMPT_COLOR="%B%F{84}"
DISTROPROMPT_ERROR_COLOR="%B%F{203}"
DISTROPROMPT_NOERROR_COLOR="%B%F{84}"
DISTROPROMPT_SHOW_DIR="right" # left, right or off
