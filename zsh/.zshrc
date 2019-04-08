export ZSH="/home/matt/.oh-my-zsh"
ZSH_THEME="gallois"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias vim="nvim "

export PATH=$PATH:$HOME/.cargo/bin

PATH=$PATH:~/bin
