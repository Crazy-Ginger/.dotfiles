#auto starts zsh in tmux after checking to ensure no nested tmux
if command -v tmux >/dev/null 2>&1; then
    # if not inside a tmux session, and if no session is started, start a new session
    [ -z "${TMUX}" ] && (tmux) >/dev/null 2>&1
fi

ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gallois"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    tmux
    shrink-path

    # testing some new plugins
    colored-man-pages
    web-search
    docker
    docker-compose
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9,underline'
bindkey '^[[1;5C' forward-word

alias vim="nvim"
alias python="python3"
alias chrome="/usr/bin/google-chrome-stable  %U"
alias svim="sudoedit"
alias pping="prettyping"
alias ip="ip -c"
alias ls-type='find -type f -name "*.*" | rev | cut -d "." -f 1 | rev | sort | uniq -c | sort -n'

# add user bin files to path
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/usr/sbin

# setup zsh history (it broke for some reason)
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

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1

# sets the directory path to be minimal by reducing to minimal chars by selecting the as many as it needs for the path to be unique
setopt prompt_subst

# appends the hostname to the terminal line if in SSH
if [[ -n $SSH_CONNECTION ]]; then
    #PS1 = "$(hostname) $PS1"
    PS1='%{$fg[magenta]%}$(hostname)%{$fg[red]%}->%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
else
    PS1='%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
fi

# Import colourscheme from 'wal' asynchronously
if command -v wal >/dev/null 2>&1; then
    (cat ~/.cache/wal/sequences &)
    source ~/.cache/wal/colors-tty.sh
fi


if command -v morse &> /dev/null; then
# For MORSE Simulator
    export MORSE_BLENDER=/usr/bin/blender
    PYTHONPATH=/usr/local/lib/python3.5/dist-packges/
    alias blender="/usr/bin/blender"
fi

if cat /proc/version | grep -q WSL; then
    export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
fi
