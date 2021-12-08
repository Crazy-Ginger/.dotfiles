# Bash
cd $HOME/.dotfiles 
rm $HOME/.bashrc 
stow bash


# Tmux
cd $HOME/.dotfiles && stow tmux
cd $HOME


# Zsh setup
chsh -s /bin/zsh
# Oh-my-zsh
CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd $HOME/.dotfiles 
rm $HOME/.zshrc 
stow zsh
cd $HOME

# oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# NVim setup
mkdir -p $HOME/.config/nvim/autoload
cd $HOME/.dotfiles && stow nvim && cd $HOME
vim +PlugInstall +qall

# Find libclang and symlinks to home dir
find /usr/ -mount -iname '*libclang.so*' -exec ln -s {} /home/becca/.libclang.so

# Set up astyle
cd $HOME/.dotfiles
stow asyle
cd $HOME

source $HOME/.zshrc
