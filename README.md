# Dotfiles

Configuration files.

## Includes:

package lists
setup.sh
Zshell config
Tmux config
Neovim config
i3 config
Urxvct config
Dunst config
Bash config
yapf style
astyle formatting for c-like's

## To Use

1. Read the documentation for each file before using it
2. Install the packages using the system's package manager (apt, pacman, etc.) and pip
3. Run `./setup.sh` to smylink config files

## More Details

- Package lists are small, only including packages needed to setup the config files and basic diagnostics
- Zsh (shell) config uses [Oh-My-Zsh](https://ohmyz.sh) which `setup.sh` will automatically install
- [Nvim](https://neovim.io) relies on [vim-plug](https://github.com/junegunn/vim-plug) for its plugins
- [i3](https://github.com/Airblader/i3) (tiling window manager), [Uxrvt](https://wiki.archlinux.org/title/rxvt-unicode) (terminal emulator) and [Dunst](https://wiki.archlinux.org/title/Dunst) (notification server) should only be installed on machines which can use GUI's (i.e. not headless servers) and so are not included in `setup.sh`
- I don't really use Bash (shell) so the config file is very under developed
- i3 relies on programs located in ~/bin which are not included in this repo, replaced these lines to avoid errors
- Urxvt & nvim rely on [pywal](https://github.com/dylanaraps/pywal) to get their colour schemes
