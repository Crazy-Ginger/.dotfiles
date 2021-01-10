#auto starts zsh in tmux after checking to ensure no nested tmux
[[ $TERM != "screen" ]] && exec tmux

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
    vscode
    web-search
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=9,underline'

alias vim="TERM=xterm-256color nvim"
alias python="python3"
alias chrome="/usr/bin/google-chrome-stable  %U"
alias ls-type='find -type f -name "*.*" | rev | cut -d "." -f 1 | rev | sort | uniq -c | sort -n'
#--force-device-scale-factor=20 [?]

# add user bin files to path
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/usr/sbin

# setup zsh history (it broke for some reason)
export HISTFILE=~/.zsh_history
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
if hostname | grep -q "BeccaArchLap"; then
    (cat ~/.cache/wal/sequences &)
    source ~/.cache/wal/colors-tty.sh
fi

# For MORSE Simulator
export MORSE_BLENDER=/usr/bin/blender
PYTHONPATH=/usr/local/lib/python3.5/dist-packges/
alias blender="/usr/bin/blender"
