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

export TERM=xterm-256color

BG=dark

# Check if we are in webstorm
if [[ $(env | grep -i storm | wc -l) > 1 ]]; then
    EDITOR=wstorm
    BG=dark
fi

export BG

# Customize to your needs...
#####
# For Linux
#####
if [[ "$OSTYPE" =~ ^linux ]]; then
    # Alias to applications
    alias pbcopy='xclip -selection clipboard'
    alias open='gnome-open'
    alias openIn='parallel -Xj1 --tty'

    alias install_history="cat /var/log/apt/history.log | grep 'apt-get install'"
    alias ack='ack-grep'
fi

#####
# For all systems
#####
alias tk='tmux kill-session'
alias tmux='tmux -2'

# Grunt autocompletion
eval "$(grunt --completion=zsh)"

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

# Terminal to vim shortcut
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

# acki: an interactive ack
acki() {
    if [[ $EDITOR == wstorm ]]; then
        $EDITOR $(ack $@ | sed 's/:/ /g' | percol | awk '{print "--line "$2 " " $1}')
    else
        $EDITOR $((ack $@ | sed 's/:/ /g' | percol | awk '{print "+"$2 " " $1}') || '-c quit')
    fi
}
grepi() {
    vim $((grep -n $@ | sed 's/:/ /g' | percol | awk '{print "+"$2 " " $1}') || '-c quit')
}

#####
# For MacOS
#####
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Add path
    PATH=$PATH:$HOME/bin

fi

# For note taking
nls() {
    $EDITOR "$(grep --include="*.md" -R -l -i "$*" $NOTES | sed 's/\$NOTES\///g' | percol)"
}
alias note='terminal_velocity'

# Add id wd not exist, download it: curl -L https://github.com/mfaerevaag/wd/raw/master/install.sh | sh
wd() {
  . $HOME/bin/wd/wd.sh
}
fpath=($HOME/bin/wd $fpath)
rm -f ~/.zcompdump; compinit
