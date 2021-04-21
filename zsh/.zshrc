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
    vscode
    web-search
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10,underline'

alias vim="nvim"
alias python="python3"
alias chrome="/usr/bin/google-chrome-stable  %U"
alias ls-type='find -type f -name "*.*" | rev | cut -d "." -f 1 | rev | sort | uniq -c | sort -nr'
#--force-device-scale-factor=20

# add user bin files to path
export PATH=$PATH:~/bin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/usr/sbin

# add local to cpp compiler
export LIBRARY_PATH="/usr/local/lib:$LIBRARY_PATH"
export INCLUDE="/usr/local/include:$INCLUDE"
# add stack bin for haskell
export PATH=$PATH:/home/becca/.stack/snapshots/x86_64-linux-tinfo6/79c880a6a9866d8f91ffe40e7020e52eed7edeea96bad2d125d3da52a788c03d/8.10.3/bin:/home/becca/.stack/compiler-tools/x86_64-linux-tinfo6/ghc-8.10.3/bin:/home/becca/.stack/programs/x86_64-linux/ghc-tinfo6-8.10.3/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/jvm/default/bin:/home/becca/bin:/home/becca/.local/bin:/usr/sbin

# zsh_history (limit size)
export HISTFILE=~/.zsh_history

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS

# limit history to 5000 lines
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

# fix alias autocomplete
zstyle ':completion:*' completer _expand_alias _complete _ignored

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
if command -v wal &> /dev/null; then
    (cat ~/.cache/wal/sequences &)
    source ~/.cache/wal/colors-tty.sh
fi

    # For MORSE Simulator
if command -v morse &> /dev/null; then
    export MORSE_BLENDER=/opt/blender-2.79b-linux-glibc219-x86_64/blender
    PYTHONPATH=/usr/local/lib/python3.5/dist-packges/
    alias blender="/opt/blender-2.79b-linux-glibc219-x86_64/blender"
fi

if cat /proc/version | grep -q WSL;then
    export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
fi
