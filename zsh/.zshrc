ZSH_DISABLE_COMPFIX=true
export ZSH="/home/becca/.oh-my-zsh"
ZSH_THEME="gallois"

plugins=(
    git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

alias vim="nvim"

export PATH=$PATH:$HOME/.cargo/bin

PATH=$PATH:~/bin

eval $(thefuck --alias)
