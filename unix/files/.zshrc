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

acki() {
    vim $((ack $@ | sed 's/:/ /g' | percol | awk '{print "+"$2 " " $1}') || '-c quit')
}
grepi() {
    vim $((grep -n $@ | sed 's/:/ /g' | percol | awk '{print "+"$2 " " $1}') || '-c quit')
}

#####
# For MacOS
#####
if [[ "$OSTYPE" == "darwin"* ]]; then
    # For note taking
    nls() {                                                                                                                                                                                    ⏎
        $EDITOR ~/Dropbox/notes/"$(grep --include="*.md" -R -l -i "$*" ~/Dropbox/notes | sed 's/\/Users\/francois\/Dropbox\/notes\///g' | percol)"
    }
fi

alias note='terminal_velocity'

# Add id wd not exist, download it: curl -L https://github.com/mfaerevaag/wd/raw/master/install.sh | sh
wd() {
  . $HOME/bin/wd/wd.sh
}
fpath=($HOME/bin/wd $fpath)
rm -f ~/.zcompdump; compinit
