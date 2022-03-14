# Bash
function bash_setup {
    cd $HOME/.dotfiles 
    rm $HOME/.bashrc 
    stow bash
}


# Tmux
function tmux_setup {
    cd $HOME/.dotfiles && stow tmux
    cd $HOME
}


# Zsh setup
function zsh_setup {
    chsh -s /bin/zsh
    # Oh-my-zsh
    CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cd $HOME/.dotfiles 
    rm $HOME/.zshrc 
    stow zsh
    cd $HOME
    source $HOME/.zshrc
}

# oh-my-zsh plugins
function omz_plugins {
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

# NVim setup
function nvim_setup {
    mkdir -p $HOME/.config/nvim/autoload
    cd $HOME/.dotfiles && stow nvim && cd $HOME
    vim +PlugInstall +qall
    astyle_setup
    yapf_setup
    pylint_setup
}

# Find libclang and symlinks to home dir
function libclang_find {
    find /usr/ -mount -iname '*libclang.so*' -exec ln -s {} /home/becca/.libclang.so
}

# Set up astyle
function astyle_setup {
    cd $HOME/.dotfiles
    stow asyle
    cd $HOME
}

# Set up yapf
function yapf_setup {
    cd $HOME/.dotfiles
    stow yapf
    cd $HOME
}

function pylint_setup {
    cd $HOME/.dotfiles
    stow pylint
    cd $HOME
}


bash_setup
tmux_setup
zsh_setup
omz_plugins
nvim_setup
libclang_find
