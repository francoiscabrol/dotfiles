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
    alias ack='ack-grep'

    alias install_history="cat /var/log/apt/history.log | grep 'apt-get install'"

fi

#####
# For all systems
#####
alias tk='tmux kill-session'

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
  . /home/fcabrol/bin/wd/wd.sh
}
