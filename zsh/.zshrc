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
