#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source $HOME/.bash_aliases

#####
# For Linux
#####
if [[ "$OSTYPE" =~ ^linux ]]; then
  # Alias to applications
  alias pbcopy='xclip -selection clipboard'
  alias open='gnome-open'
  alias openIn='parallel -Xj1 --tty'
  alias install_history="cat /var/log/apt/history.log | grep 'apt-get install'"
fi

#####
# For MacOS
#####
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Add path
    PATH=$PATH:$HOME/bin
fi

#####
# For all systems
#####
function getBG() {
  profile=${ITERM_PROFILE:-dark}
  echo "$profile" | awk '{print tolower($0)}'
}

# Set editor properties
BG=$(getBG)
EDITOR=nvim

# Check if we are in webstorm
if [[ $(env | grep -i ZDOT | wc -l | xargs) > 0 ]]; then
    EDITOR=webstorm
    BG=dark
fi

export BG

# Bind the vi command to the default $EDITOR
alias vi=$EDITOR

alias tk='tmux kill-session'
alias tmux='tmux -2'

# Grunt autocompletion
if hash grunt 2>/dev/null; then
  eval "$(grunt --completion=zsh)"
fi

gcom () {
    git stash
    gco "$*"
    git stash pop
}

# Automatically change the directory in bash after closing ranger
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/local/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
alias rcd='ranger-cd'

# Terminal to vi shortcut
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Task warrior - filter by project
function t() {
    project=$(basename `pwd`);
    tp=( $(task _projects | grep $project) );

    if [[ -n $tp ]]; then
        task "$@" project:$project;
    else
        task "$@"
    fi
}

# agi: an interactive ack
agi() {
  if [[ $EDITOR == wstorm ]]; then
    $EDITOR $(ag $@ | sed 's/:/ /g' | fzf | awk '{print "--line "$2 " " $1}')
  elif [[ $EDITOR == vim || $EDITOR == nvim ]]; then
    $EDITOR $((ag $@ | sed 's/:/ /g' | fzf | awk '{print "+"$2 " " $1}') || '-c quit')
  else
    # By default open the file in vim/nvim
    vi $((ag $@ | sed 's/:/ /g' | fzf | awk '{print "+"$2 " " $1}') || '-c quit')
  fi
}

# For note taking
nls() {
  if [[ -n "$@" ]]; then
    agi $@ $NOTES
  else
    agi -g . $NOTES
  fi
}
alias note='terminal_velocity'

# Add id wd not exist, download it: curl -L https://github.com/mfaerevaag/wd/raw/master/install.sh | sh
wd() {
  . $HOME/bin/wd/wd.sh
}
fpath=($HOME/bin/wd $fpath)
rm -f ~/.zcompdump; compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# auto suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
