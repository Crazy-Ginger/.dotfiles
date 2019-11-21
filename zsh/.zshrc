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
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

alias vim="nvim"
alias startx="startxfce4"


export PATH=$PATH:$HOME/.cargo/bin
PATH=$PATH:~/bin

eval $(thefuck --alias)

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1

#should shrink the file path displayed by zsh so it takes up less space whilst still being unique to each directory
setopt prompt_subst
#PS1='[$(shrink_path -f)]$ '
#temp = "$(shrink_path -T)"
PS1='%{$fg[cyan]%}[$(shrink_path -t)]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
