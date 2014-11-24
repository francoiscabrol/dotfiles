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

# Customize to your needs...
if [[ "$OSTYPE" =~ ^linux ]]; then
     alias pbcopy='xclip -selection clipboard'
     alias open='gnome-open'
     alias openIn='parallel -Xj1 --tty'
     #
     # Shortcut to folder
     alias cdNote='cd /home/fcabrol/Dropbox/Notes/SchneiderElectric'

     export PATH="/home/fcabrol/npm/bin:$PATH"
fi

alias tk='tmux kill-session'

if [[ "$OSTYPE" == "darwin"* ]]; then

    ## Use local in priority
    export PATH="/usr/local/bin:$PATH"

    ##Leap motion sdk##
    export LEAP_HOME="/Users/francois/Applications/LeapSDK"

    ##Java##
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home"
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
    alias cdtraining='cd /Users/francois/Movies/Tutorials/Entrainement'

    ##Shortcuts to application
    alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
    alias rtt='/Users/francois/Applications/Read2Text1/read2text'
    alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

fi
