#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
# eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]];then
    exec startx
fi
source "$HOME/.cargo/env"
