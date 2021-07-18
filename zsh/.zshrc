#auto starts zsh in tmux after checking to ensure no nested tmux
if command -v tmux >/dev/null 2>&1; then
    # if not inside a tmux session, and if no session is started, start a new session
    [ -z "${TMUX}" ] && (tmux) >/dev/null 2>&1
fi

# speed up zsh on large git repos
DISABLE_UNTRACKED_FILES_DIRTY="true"

ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gallois"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    tmux
    shrink-path
    colored-man-pages
    web-search
    docker
    docker-compose
    vscode
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9,underline'
bindkey '^[[1;5C' forward-word

alias vim="nvim"
alias python="python3"
alias chrome="/usr/bin/google-chrome-stable  %U"
alias ip="ip -c"
alias pping="prettyping"
alias svim="sudoedit"
alias ls-type='find -type f -name "*.*" | rev | cut -d "." -f 1 | rev | sort | uniq -c | sort -nr'

## WSL
alias expl="explorer.exe ."
alias notepad="notepad.exe"

# add user bin files to path
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/usr/sbin

# add /usr/local/ to cpp compiler
export LIBRARY_PATH="/usr/local/lib:$LIBRARY_PATH"
export INCLUDE="/usr/local/include:$INCLUDE"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

# set zsh_history
export HISTFILE=~/.zsh_history

# trying to reduce History size after cutting it down manually
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
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1

# sets the directory path to be minimal by reducing to minimal chars by selecting the as many as it needs for the path to be unique
setopt prompt_subst

# checks if git info should be displayed (for large repos)
#if [ -z $(git config --get .oh-my-zsh.hide-info) ]; then
    # appends the hostname to the terminal line if in SSH
    if [[ -n $SSH_CONNECTION ]]; then
        #PS1 = "$(hostname) $PS1"
        PS1='%{$fg[magenta]%}$(hostname)%{$fg[red]%}->%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
    else
        PS1='%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
    fi
#else
    ## appends the hostname to the terminal line if in SSH
    #if [[ -n $SSH_CONNECTION ]]; then
        #PS1='%{$fg[magenta]%}$(hostname)%{$fg[red]%}->%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
    #else
        #PS1='%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
    #fi

#fi

# Import colourscheme from 'wal' if desktop environment
if command -v wal &> /dev/null; then
    (cat ~/.cache/wal/sequences &)
    source ~/.cache/wal/colors-tty.sh
fi

# For MORSE Simulator
if command -v morse &> /dev/null; then
    export MORSE_BLENDER=/usr/bin/blender
    PYTHONPATH=/usr/local/lib/python3.5/dist-packges/
    alias blender="/usr/bin/blender"
fi

if cat /proc/version | grep -q WSL; then
    export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
fi

# Runs Spack (if it exists)
if command -v spack &> /dev/null; then
    source ~/spack/share/spack/setup-env.sh
fi
