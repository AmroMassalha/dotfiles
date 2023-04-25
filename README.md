# My config Repo
This repository contains configuration files for various tools, including:

* Alacritty
* Neovim
* Sheldon
* Starship
* Tmux
* Zsh

To use these configurations, follow the steps below:

## Installation
1. Install the packages listed in the `Brewfile` file using your package manager. If you're on macOS, you can use [Homebrew] (https://brew.sh/) by running `brew bundle install` from the root of the repository.

2. Clone the repository to your home directory:
```bash
git clone https://github.com/AmroMassalha/my_config.git
```

3. Link the `.zshrc` file to your home directory:
```bash
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
```

4. Source the `tmux.conf` file by running:
```bash
tmux source ~/.config/tmux/tmux.conf
```

# Usage
## [Alacritty] (https://alacritty.org/)
Alacritty is a terminal emulator that uses GPU acceleration to render the terminal screen. To use the Alacritty configuration, copy the `alacritty.yml` file to `~/.config/alacritty/`.

## [Neovim] (https://neovim.io/)
Neovim is a modern Vim-based text editor with advanced features. To use the Neovim configuration, copy the `init.vim` file to `~/.config/nvim/`.

## [Sheldon] (https://sheldon.cli.rs/)
Sheldon is a command-line tool that helps you manage and run shell commands. To use the Sheldon configuration, copy the `sheldon.toml` file to `~/.config/sheldon/`.

## [Starship] (https://starship.rs/)
Starship is a minimalistic, blazing-fast prompt for any shell. To use the Starship configuration, copy the `starship.toml` file to `~/.config/`.

## [Tmux] (https://github.com/tmux/tmux/wiki)
Tmux is a terminal multiplexer that allows you to switch easily between several programs in one terminal. To use the Tmux configuration, copy the `tmux.conf` file to `~/.config/tmux/`.

## [Zsh] (https://www.zsh.org/#:~:text=Zsh%20is%20a%20shell%20designed,Zsh%20Web%20Pages)
Zsh is a powerful shell with advanced scripting features. To use the Zsh configuration, copy the `.zshrc` file to `~/.config/zsh/`. The .zshrc file includes several plugins and configurations that enhance the shell experience.
