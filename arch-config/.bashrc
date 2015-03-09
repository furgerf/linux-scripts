#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bash texts
echo -e '\e[0;37mWelcome to the \e[1;34mother side\e[0;37m...\n'
PS1="\[\033[1;30m\][\[\033[01;37m\]\$?\$(if [[ \$? == 0 ]]; then echo \"  \[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi)\[\033[1;30m\]][\[\033[1;37m\]\A\[\033[1;30m\]][\[\033[1;37m\]\u\[\033[1;30m\]@\[\033[1;37m\]\h\[\033[1;30m\]][\[\033[1;37m\]\w\[\033[1;30m\]]\[\033[1;34m\]\$\[\033[0;37m\] "

# CERTAINLY(-ish) working
#PS1="\[\033[1;30m\][\[\033[1;37m\]\A\[\033[1;30m\]][\[\033[1;37m\]\u\[\033[1;30m\]@\[\033[1;37m\]\h\[\033[1;30m\]][\[\033[1;37m\]\w\[\033[1;30m\]]\[\033[1;34m\]\$\[\033[0;37m\] "

# vanilla
#PS1='[\u@\h \W]\$ '
# exports
export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/home/fabian/perl5"
export PERL_MB_OPT="--install_base /home/fabian/perl5"
export PERL_MM_OPT="INSTALL_BASE=/home/fabian/perl5"
export PERL5LIB="/home/fabian/perl5/lib/perl5:$PERL5LIB"
export EDITOR="vim"
#export TERM="xfce4-terminal"
#export TERM="xterm"
export PATH="$PATH:/opt/android-sdk/tools:/opt/android-sdk/build-tools:/opt/android-sdk/platform-tools"
export HISTSIZE=5000
export HISTCONTROL=ignoredups

# highlight broken symlinks
eval $(dircolors -b) 

# "command not found" hook
source /usr/share/doc/pkgfile/command-not-found.bash
source /usr/share/git/completion/git-completion.bash

# auto-cd when entering path
shopt -s autocd
# fixes line shenanigans(?)
shopt -s checkwinsize

# modified commands
alias diff='colordiff -s'              # requires colordiff package
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias cd='cd -P'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'      # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pg='ps -Af | grep $1'         # requires an argument (note: /usr/bin/pg is installed by the util-linux package; maybe a different alias name should be used)

# privileged access
if [ $UID -ne 0 ]; then
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
    alias mount='sudo mount'
    alias umount='sudo umount'
fi

# ls
alias ls='ls -lhF --color=auto'
alias lr='ls -R'                    # recursive ls
alias la='ls -A'
alias lx='la -BX'                   # sort by extension
alias lz='la -rS'                   # sort by size
alias lt='la -rt'                   # sort by date
alias ll='la | less'

# safety features
#alias cp='cp -i'
#alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# pacman
alias pac="sudo /usr/bin/pacman -S"		# default action	- install one or more packages
alias pacu="sudo /usr/bin/pacman -Syu"		# '[u]pdate'		- upgrade all packages to their newest version
alias pacy="sudo /usr/bin/pacman -Syy"  # rebuild local database
alias pacr="sudo /usr/bin/pacman -Rs"		# '[r]emove'		- uninstall one or more packages
alias pacs="/usr/bin/pacman -Ss"		# '[s]earch'		- search for a package using one or more keywords
alias pacq="/usr/bin/pacman -Qs"
alias paci="/usr/bin/pacman -Si"		# '[i]nfo'		- show information about a package
alias paclo="/usr/bin/pacman -Qdt"		# '[l]ist [o]rphans'	- list all packages which are orphaned
alias pacc="sudo /usr/bin/pacman -Scc"		# '[c]lean cache'	- delete all not currently installed package files
alias paclf="/usr/bin/pacman -Ql"		# '[l]ist [f]iles'	- list all files installed by a given package
alias pacexpl="/usr/bin/pacman -D --asexp"	# 'mark as [expl]icit'	- mark one or more packages as explicitly installed 
alias pacimpl="/usr/bin/pacman -D --asdep"	# 'mark as [impl]icit'	- mark one or more packages as non explicitly installed
# '[r]emove [o]rphans' - recursively remove ALL orphaned packages
alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rs \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')"

# yaourt http://www.doodle.com/dy7cg2qqkd6vicst
alias ya="/usr/bin/yaourt -S"
alias yau="/usr/bin/yaourt -Syau"
alias yas="/usr/bin/yaourt -Ss"
alias yaq="/usr/bin/yaourt -Qs"
alias yar="/usr/bin/yaourt -Rs"

# "vim"-commands
alias :q='exit'
alias :Q='exit'

alias covremote='rdesktop -u furgerf@coventry.ac.uk -g 1024x650 -k de-ch cu2study.coventry.ac.uk -p 1Tennarvet.'

alias multigource='~/git/linux-scripts/multigource'
alias gourcevideo='gource -1280x720 -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 gource.mp4'
alias git-pull='~/git/linux-scripts/git-pull ~/git'

alias image='geeqie'
alias imagefind='find . -name "*" -exec file {} \; | /usr/bin/grep -o -P "^.+: \w+ image"'
pdf() {
    okular "$1" &> /dev/null &
}
#pdfa() {
#    for i in $1/*.pdf; do echo $i; done &
#}
alias pdfa='for i in *.pdf; do pdf "$i"; done'

alias doodle='firefox -new-tab http://www.doodle.com/dy7cg2qqkd6vicst'
alias libreoffice='/usr/bin/libreoffice --nologo'

# android dev
alias logcat="$HOME/git/linux-scripts/logcat"

# wine shortcuts
alias windir="cl $HOME/.wine/drive_c/Program\ Files\ \(x86\)/"
alias sacred="xfce4-terminal --working-directory $HOME/.wine/drive_c/Program\ Files\ \(x86\)/Ascaron\ Entertainment/Sacred\ Underworld/ -x wine Sacred.exe"

alias winmount="mount /dev/sdb1 /win"
alias term='xfce4-terminal'
execterm () {
    #xfce4-terminal -e "env PROMPT_COMMAND; $@ bash"
    xfce4-terminal -e "bash -c '$@; exec bash'"
}

alias cp='acp -agi'
alias mv='amv -gi'

alias xclip='xclip -selection c'

alias fucking='sudo'

alias refresh_conky='killall conky ; conky -d -c $HOME/git/linux-scripts/conky/.conkyrc'

recent() {
    #if [[ "$1" =~ '^[0-9]+$' ]]; then
    if [ "$1" -eq "$1" ] 2>/dev/null; then
        find -maxdepth "$1" -type f -mtime -1 -printf "%T@ - %Tk:%TM - %f\n" | sort -rn | cut -d- -f2-
    else
        find -maxdepth 1 -type f -mtime -1 -printf "%T@ - %Tk:%TM - %f\n" | sort -rn | cut -d- -f2-
    fi
}

## Functions
# cd and ls in one
cl() {
    if [[ -d "$1" ]]; then
        cd "$1"
        la
    else
        echo "bash: cl: '$1': Directory not found"
    fi
}

todo() {
    if [[ ! -f /data/Dropbox/misc/misc/todo.txt ]]; then
        touch /data/Dropbox/misc/misc/todo.txt	
    fi
    if [[ ! -f /data/Dropbox/misc/misc/todo_history.txt ]]; then
        touch /data/Dropbox/misc/misc/todo_history.txt
    fi

    if [[ $# -eq 0 ]]; then
        cat -n /data/Dropbox/misc/misc/todo.txt
    elif [[ "$1" == "-l" ]]; then
        cat -n /data/Dropbox/misc/misc/todo.txt
    elif [[ "$1" == "-h" ]]; then
        cat -n /data/Dropbox/misc/misc/todo_history.txt
    elif [[ "$1" == "-c" ]]; then
        echo "" > /data/Dropbox/misc/misc/todo.txt
    elif [[ "$1" == "-r" ]]; then
        cat -n /data/Dropbox/misc/misc/todo.txt
        echo -ne "----------------------------\nType a number to remove: "
        read NUMBER
        sed -ie ${NUMBER}d /data/Dropbox/misc/misc/todo.txt
    else
        echo "$@" >> /data/Dropbox/misc/misc/todo.txt
        echo $(date "+%A, %B %d, %Y [%T]") "$@" >> /data/Dropbox/misc/misc/todo_history.txt
    fi
}

finished () {
    sed -i "$1"d /data/Dropbox/misc/misc/todo.txt
}

p4 () {
    STATUS=0
    LOOP=1

    while [ "$LOOP" -eq 1 ]; do
        ping 4.2.2.2
        STATUS=$?
        if [ $STATUS -eq 0 ]; then
           LOOP=0
        else
           sleep 1
        fi
    done
}

p8 () {
    STATUS=0
    LOOP=1

    while [ "$LOOP" -eq 1 ]; do
        ping 8.8.8.8
        STATUS=$?
        if [ $STATUS -eq 0 ]; then
           LOOP=0
        else
           sleep 1
        fi
    done
}

yoghurt () {
    first=1

    sudo echo "foo" > /dev/null

    ping 8.8.8.8 -c 1 &> /dev/null

    while [ $? -ne 0 ]; do
        if [ $first -eq 1 ]; then
            echo "Waiting for connection..."
            first=0
        fi

        sleep 1
        ping 8.8.8.8 -c 1 &> /dev/null
    done

    yau
}

alias mirror='mplayer -vf mirror -v tv:// -tv device=/dev/video0:driver=v4l2'
alias files='file $(/usr/bin/ls -aH)'
alias speak='time echo \""$@"\" | ( Equalizer || espeak || say -v Fred || cat)' # FIX ME :(

pjson() {
    python2 $HOME/git/linux-scripts/pjson.py
    # python2 $HOME/git/linux-scripts/pjson.py | less -X
}

alias labyrinth='while ( true ) ; do if [ $( expr $RANDOM % 2 ) -eq 0 ] ; then echo -ne "\xE2\x95\xB1" ; else echo -ne "\xE2\x95\xB2" ; fi ; done'

alias agora='cd /home/fabian/git/cu/305cde/Agora && execterm "npm start" && execterm vim && git remote update && git status'
alias dissertation='cd $HOME/git/cu/300com/300com-final-project/dissertation && pdf main.pdf && vim main.tex'

x(){
    if [ -f $1 ] ; then
            case $1 in
                    *.tar.bz2)   tar xvjf $1    ;;
                    *.tar.gz)    tar xvzf $1    ;;
                    *.bz2)       bunzip2 $1     ;;
                    *.rar)       unrar x $1     ;;
                    *.gz)        gunzip $1      ;;
                    *.tar)       tar xvf $1     ;;
                    *.tbz2)      tar xvjf $1    ;;
                    *.tgz)       tar xvzf $1    ;;
                    *.zip)       unzip $1       ;;
                    *.Z)         uncompress $1  ;;
                    *.7z)        7z x $1        ;;
                    *)           echo "Unable to extract '$1'" ;;
            esac
    else
            echo "'$1' is not a valid file"
    fi
}

sus(){ 
  sort | uniq -c | sort $@;
}

say(){
  curl -A RG translate\.google\.com/translate_tts -d "tl=en&q=$@" | mpg123 -;
}

# disable flow control (to use ctrl+s in vim)
stty -ixon

# git
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gd='git diff'
alias pull='git pull'
alias push='git push'

