#auto starts zsh in tmux after checking to ensure no nested tmux
tmux new-session;
if [ "$TMUX" = "" ]; then
<<<<<<< HEAD
    exit
=======
	exit
>>>>>>> 1decaab08cf6a34de6ed68da04c096004717a947
fi

ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gallois"

plugins=(
    git
    zsh-autosuggestions
	zsh-syntax-highlighting
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

