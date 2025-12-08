# OS symbol
__distro_icon() {
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
