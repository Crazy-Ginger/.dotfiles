#auto starts zsh in tmux after checking to ensure no nested tmux
if command -v tmux >/dev/null 2>&1; then
    # if not inside a tmux session, and if no session is started, start a new session
    [ -z "${TMUX}" ] && (tmux) >/dev/null 2>&1
fi
# DISABLE_UNTRACK_FILE_DIRTY="true"

# enables profiling to diagnose slowness, should probably be disabled for performance?
# zmodload zsh/zprof

# ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
# export TERMINAL=alacritty
plugins=(
    git
    tmux
    zsh-autosuggestions
    shrink-path
    colored-man-pages
    web-search
    docker
    docker-compose
    dotenv
    systemd
    zsh-syntax-highlighting
    fd
    k
)

export FZF_DEFAULT_OPTS="--cycle"

# loads .oh-my-zsh
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9,underline'

# TODO: check what p10k actually does
# Holding off trying out powerlevel10k (for the speed)
# ZSH_THEME="powerlevel10k/powerlevel10k"

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

if cat /proc/version | grep -q WSL; then
    alias expl="explorer.exe ."
    alias notpad="notepad.exe"
fi


#########
##Paths##
#########

# add user bin files to path
export PATH="$PATH:$HOME/bin:.local/bin:/usr/sbin"
# export PATH=$PATH:/usr/include


# XDG file paths setup (using defaults)
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"


# add openCV paths for compilation
export LIBRARY_PATH="/usr/local/lib:$LIBRARY_PATH"
export C_INCLUDE_PATH="/usr/local/include:$C_INCLUDE_PATH"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

# Move Go directory to /opt
export GOPATH="$HOME/Source/go"

###############
##Zsh History##
###############

# set zsh_history
export HISTFILE=~/.zsh_history

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY

# limit history to 5,000 lines
HISTSIZE=10000
SAVEHIST=10000

# Doesn't add command to history if it returns a failure code (e.g. mistypes)
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# set neovim as the default editor
export EDITOR=nvim
export VISUAL=nvim

export PAGER="less --mouse"
export BAT_PAGER="less --mouse"
export MANPAGER="less --mouse"

# stuff to do with autocomplete possibly (not sure)
autoload -Uz compinit && compinit
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


## Stolen from Gallois
# Depends on the git plugin for work_in_progress()
(( $+functions[work_in_progress] )) || work_in_progress() {}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# # Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
    local branch=$(git_current_branch)
    [[ -n "$branch" ]] || return 0
    echo "$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_PREFIX}${branch}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

# Combine it all into a final right-side prompt
RPS1="\$(git_custom_status)"

## end stolen section


# Set Ctrl + left arrow to forward word on certain systems
if ! [[ $(cat /proc/version | grep -q arch) ]]; then
    bindkey '^[[1;5C' forward-word
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

# Add paraview's python package if present
if [[ -d "/opt/paraview" ]]; then
    export PYTHONPATH="/opt/paraview/lib/python3.10/site-packages/:${PYTHONPATH}"
fi

# Enable OpenFOAM zsh fixes
if [[ -d "/opt/OpenFOAM" ]]; then
    # autoload bashcompinit
    # bashcompinit
    export FOAM_INST_DIR=/opt/OpenFOAM
    export BASH=/bin/bash
    alias ofoam="source ${FOAM_INST_DIR}/OpenFOAM-v2206/etc/bashrc"
    alias paraFoam='parafoam -builtin'
fi

# Setup Spack if installed
if command -v spack &> /dev/null; then
    source ~/spack/share/spack/setup-env.sh
fi

# Add cargo to PATH if installed
if command -v cargo &> /dev/null; then
    export PATH=$PATH:~/.cargo/bin
fi

# Add cuda to PATH if installed
if [[ -d "/usr/local/cuda" ]]; then
    export PATH=$PATH:/usr/local/cuda/bin
fi

# Setup pyenv if installed
if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    eval "$(pyenv init -)"
fi

# Add go bin to PATH is go location is set
if [[ -d "$HOME/Source/go" ]]; then
    export PATH="$PATH:$HOME/Source/go/bin"
fi

# Turn ros2 on
ros2_on(){
    export ROS_DOMAIN_ID=42
    export ROS_VERSION=2
    export ROS_PYTHON_VERSION=3
    export ROS_DISTRO=galactic
    source /opt/ros2/galactic/setup.zsh
}

webots_on(){
    export WEBOTS_HOME="/usr/local/webots"
    LD_LIBRARY_PATH="$WEBOTS_HOME/lib/controller:$LD_LIBRARY_PATH"
    PYTHONPATH="$WEBOTS_HOME/lib/controller/python:$PYTHONPATH"
    PYTHONIOENCODING=UTF-8
}
