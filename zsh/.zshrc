#auto starts zsh in tmux after checking to ensure no nested tmux
if command -v tmux >/dev/null 2>&1; then
    # if not inside a tmux session, and if no session is started, start a new session
    [ -z "${TMUX}" ] && (tmux) >/dev/null 2>&1
fi

DISABLE_UNTRACK_FILE_DIRTY="true"

ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gallois"

plugins=(
    git
    zsh-autosuggestions
    tmux
    shrink-path
    colored-man-pages
    web-search
    docker
    docker-compose
    vscode
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9,underline'


###########
##Aliases##
###########

alias vim="nvim"
alias python="python3"
alias pip="pip3"
alias ip="ip -c"
alias pping="prettyping"
alias svim="sudoedit"
alias chrome="/usr/bin/google-chrome-stable  %U"
alias ls-type='find -type f -name "*.*" | rev | cut -d "." -f 1 | rev | sort | uniq -c | sort -nr'
# alias dockerstopper="docker stop $(docker ps -a -q)"

if cat /proc/version | grep -q WSL; then
    alias expl="explorer.exe ."
    alias notpad="notepad.exe"
fi

#########
##Paths##
#########

# add user bin files to path
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/usr/sbin

# add /usr/local/ to cpp compiler
export LIBRARY_PATH="/usr/local/lib:$LIBRARY_PATH"
export INCLUDE="/usr/local/include:$INCLUDE"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

###############
##Zsh History##
###############
# set zsh_history
export HISTFILE=~/.zsh_history

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS

# limit history to 5,000 lines
HISTSIZE=5000
SAVEHIST=5000

# set neovim as the default editor
export EDITOR=nvim
export VISUAL=nvim

eval $(thefuck --alias)

# stuff to do with autocomplete possibly (not sure)
#autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
setopt nocompletealiases

# fix alias autocomplete
zstyle ':completion:*' completer _expand_alias _complete _ignored

# sets the directory path to be minimal by reducing to minimal chars by selecting the as many as it needs for the path to be unique
setopt prompt_subst

# TODO: look into disabling git status for large repos
# use: git config --get .oh-my-zsh.hide-info
__git_prompt_git () {
	GIT_OPTIONAL_LOCKS=0 command timeout 0.3s git "$@"
}


# appends the hostname to the terminal line if in SSH
if [[ -n $SSH_CONNECTION ]]; then
    #PS1 = "$(hostname) $PS1"
    PS1='%{$fg[magenta]%}$(hostname)%{$fg[red]%}->%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
else
    PS1='%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
fi


# Set Ctrl + left arrow to forward word on certain systems
if ! [[ $(cat /proc/version | grep -q arch) ]]; then
    bindkey '^[[1;5C' forward-word

    # if paraview workaround is installed add to path
    [[ -d "/opt/paraview-opt" ]] && export PATH=$PATH:/opt/paraview-opt/bin
fi


# Import colourscheme from wal if desktop environment
if command -v wal &> /dev/null; then
    (cat ~/.cache/wal/sequences &)
    source ~/.cache/wal/colors-tty.sh
fi


# Setup MORSE Simulator if installed
if command -v morse &> /dev/null; then
    export MORSE_BLENDER=/opt/blender-2.79b-linux-glibc219-x86_64/blender
    PYTHONPATH=/usr/local/lib/python3.5/dist-packges/
    alias blender="/opt/blender-2.79b-linux-glibc219-x86_64/blender"
fi


# Setup display for wsl to run through XServer
if cat /proc/version | grep -q WSL; then
    export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
fi


# Setup Spack if installed
if command -v spack &> /dev/null; then
    source ~/spack/share/spack/setup-env.sh
fi

if command -v cargo &> /dev/null; then
    export PATH=$PATH:~/.cargo/bin
fi

# Turn ros2 on
ros2_on(){
     export ROS_DOMAIN_ID=42
     export ROS_VERSION=2
     export ROS_PYTHON_VERSION=3
     export ROS_DISTRO=foxy
     source /opt/ros2/foxy/setup.zsh
}
