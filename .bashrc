
# Check for an interactive session
[ -z "$PS1" ] && return

#alias ls='ls --color=auto'
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

export EDITOR="/usr/bin/nano"

#export PATH=$(cope_path):$PATH=${PATH}:/opt/android-sdk/platform-tools:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/share/perl5/vendor_perl/auto/share/dist/Cope

#alias pacman='pacman-color'
#export PATH="/usr/lib/cw:$PATH"

export GREP_COLOR="1;33"
alias poweroff='sudo systemctl poweroff'
alias pss='pacman -Ss'
alias yss='yaourt -Ss'
alias grep='grep --color=auto'
#alias steam='wine ~/.wine/drive_c/Program\ Files\ 
#\(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'
alias update='sudo pacman -Syu' 
alias aurup='sudo yaourt -Syu --aur'
alias ping='ping -c 4'
alias netup='sudo netctl start Tomato24'
alias netdown='sudo netctl stop Tomato24'
alias ipdown='sudo ip link set wlp3s0 down'
alias ipup='sudo ip link set wlp3s0 up'
alias xres='xrdb ~/.Xresources'

ext () {
    if [ ! -f "$1" ] ; then
      echo "'$1' is not a valid file!"
      return 1
    fi

    # Assoc. array of commands for extracting archives
    declare -A xcmd
    xcmd=(
      [.tar.bz2]="tar xvjf"
      [.tar.gz]="tar xvzf"
      [.bz2]="bunzip2"
      [.rar]="unrar x"
      [.gz]="gunzip"
      [.tar]="tar xvf"
      [.zip]="unzip"
      [.Z]="uncompress"
      [.7z]="7z x"
    )
    # extension aliases
    xcmd[.tbz2]="${xcmd[.tar.bz2]}"
    xcmd[.tgz]="${xcmd[.tar.gz]}"

    # See which extension the given file uses
    fext=""
    for i in ${!xcmd[@]}; do
      if [ $(grep -o ".\{${#i}\}$" <<< $1) == "$i" ]; then
        fext="$i"
        break
      fi
    done

    # Die if we couldn't discover what archive type it is
    if [ -z "$fext" ]; then
      echo "don't know how to extract '$1'..."
      return 1
    fi

    # Extract & cd if we can
    fbase=$(basename "$1" "$fext")
    if ${xcmd[$fext]} "$1" && [ -d "$fbase" ]; then
      cd "$fbase"
    fi
}
