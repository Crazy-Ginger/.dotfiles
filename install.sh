cd  ~ && git clone https://www.github.com/Crazy-Ginger/.dotfiles

rm ~/.bashrc && stow ~/.dotfiles/bash

# Tmux
stow ~/.tmux

# Zsh setup
chsh -s /bin/zsh
# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc && stow ~/.dotfiles/zsh

# oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# NVim setup
mkdir -p ~/.config/nvim/autoload
stow ~/.dotfiles/nvim
vim +PlugInstall +qall
