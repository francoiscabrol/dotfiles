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

    # Shortcut to folder
    alias cdnote='cd /home/fcabrol/Dropbox/Notes/SchneiderElectric'
    alias cdprojects='cd /home/fcabrol/Workspace'

    export PATH="/home/fcabrol/npm/bin:$PATH"
    # For note taking
    nls() {
        evim ~/Dropbox/Notes/"$(grep --include="*.md" -R -l -i "$*" ~/Dropbox/Notes/ | sed 's/\/home\/fcabrol\/Dropbox\/Notes\///g' | percol)" &
    }
    nrm() {
        rm ~/Dropbox/Notes/"$(grep --include="*.md" -R -l -i "$*" ~/Dropbox/Notes/ | sed 's/\/home\/fcabrol\/Dropbox\/Notes\///g' | percol)" &
    }
    rfind() {
        tree --prune -P "*$**"
    }
    alias install_history="cat /var/log/apt/history.log | grep 'apt-get install'"

fi

#####
# For all systems
#####
alias tk='tmux kill-session'

# Grunt autocompletion
eval "$(grunt --completion=zsh)"

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


#####
# For Linux
#####
if [[ "$OSTYPE" == "darwin"* ]]; then

    ## Use local in priority
    export PATH="/usr/local/bin:$PATH"

    ##Leap motion sdk##
    export LEAP_HOME="/Users/francois/Applications/LeapSDK"

    ##Java##
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk/Contents/Home"
    export PATH=$JAVA_HOME/bin:$PATH

    ##Vim##
    export PATH="/Users/francois/Applications/vim:$PATH"
    export EDITOR='vim'

    ##scala##
    export SCALA_HOME='/Users/francois/Applications/scala-2.10.4'
    export PATH=$SCALA_HOME/bin:$PATH

    ##postgres##
    export DATABASE_URL="jdbc:postgresql://localhost:5432/sharplinker?user=sharplinkeruser&password=mushroom"
    export PGDATA=/usr/local/var/postgres

    ##Shortcuts to folder
    alias cdfrancoiscabrol.github.source='cd /Users/francois/Dropbox/Workspaces/francoiscabrol.github.source'
    alias cdnotes='cd /Users/francois/Dropbox/Notes'
    alias cdprojects='cd /Users/francois/Dropbox/Workspaces/'

    ##Shortcuts to application
    alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
    alias rtt='/Users/francois/Applications/Read2Text1/read2text'
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

    # For note taking
    nls() {                                                                                                                                                                                    ⏎
        $EDITOR ~/Dropbox/notes/"$(grep --include="*.md" -R -l -i "$*" ~/Dropbox/notes | sed 's/\/Users\/francois\/Dropbox\/notes\///g' | percol)"
    }
fi

alias note='terminal_velocity'
