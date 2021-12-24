#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#PS1='[\u@\h \W]\$ '
#PS1='\[\033[01;32m\][\A] \033[01;33m\u \033[01;31m>\033[00m '
PS1="\[\033[38;5;2m\]\u\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]@\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;1m\]\W\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;3m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
export VISUAL=vi
export EDITOR=vim
export TERMINAL=/bin/kitty
export RUST_SRC_PATH=/home/filipe/code/rust
export TERM=xterm-256color
export PATH="$HOME/.local/bin:$PATH"
#export QT_STYLE_OVERRIDE=adwaita-dark
#export QT_QPA_PLATFORMTHEME=gnome
source /usr/share/nvm/init-nvm.sh
source $HOME/scripts/aliases
source $HOME/scripts/goto.sh
source $HOME/scripts/clip.sh
HISTSIZE=100000

#export BROWSER=firefox
# File extractor
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#########################
##
## Function to tail most recent file in dir
## credits to -> https://superuser.com/questions/117596/how-to-tail-the-latest-file-in-a-directory
##
##########################

latest-file-in-directory () {
    find "${@:-.}" -maxdepth 1 -type f -printf '%T@.%p\0' | \
            sort -znr -t. -k1,2 | \
            while IFS= read -r -d '' -r record ; do
                    printf '%s' "$record" | cut -d. -f3-
                    break
            done
}
#neofetch


