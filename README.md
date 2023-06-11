# My Config Repo
This repository contains configuration files for various tools, including:

* Alacritty
* Neovim (specifically, [LunarVim](https://www.lunarvim.org/))
* Sheldon
* Starship
* Tmux
* Zsh

## Prerequisites
Ensure the following software is installed:

* Python 3.10 or higher
* Latest stable versions of Node.js and npm
* Latest stable version of Neovim
* Zsh
* fzf
* Other packages listed in the `Brewfile` file (installable with [Homebrew](https://brew.sh/) on macOS)

## Installation
1. Install the packages listed in the `Brewfile` file using your package manager. If you're on macOS, you can use Homebrew by running `brew bundle install` from the root of the repository.

2. Clone the repository to your home directory:

```bash
git clone https://github.com/AmroMassalha/my_config.git
```

3. Link the `.zshrc` file to your home directory:

```bash
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
```

4. Clone and install tmux plugin manager (tpm) in your home directory:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

5. Launch a new tmux session and press `prefix + I` (where prefix is `ctrl-a` by default) to install the plugins.

6. Source the `tmux.conf` file by running:

```bash
tmux source ~/.config/tmux/tmux.conf
```

## Usage
### [Alacritty](https://github.com/alacritty/alacritty)
Alacritty is a terminal emulator that uses GPU acceleration to render the terminal screen. To use the Alacritty configuration, copy the `alacritty.yml` file to `~/.config/alacritty/`.

### [LunarVim](https://www.lunarvim.org/)
LunarVim is a distribution of Neovim that aims to simplify its configuration. To use the LunarVim configuration, copy the `config.lua` file to `~/.config/nvim/`.

### [Sheldon](https://github.com/rossmacarthur/sheldon)
Sheldon is a command-line tool that helps you manage and run shell commands. To use the Sheldon configuration, copy the `sheldon.toml` file to `~/.config/sheldon/`.

### [Starship](https://starship.rs/)
Starship is a minimalistic, blazing-fast prompt for any shell. To use the Starship configuration, copy the `starship.toml` file to `~/.config/`.

### [Tmux](https://github.com/tmux/tmux/wiki)
Tmux is a terminal multiplexer that allows you to switch easily between several programs in one terminal. To use the Tmux configuration, copy the `tmux.conf` file to `~/.config/tmux/`.

### [Zsh](https://www.zsh.org/)
Zsh is a powerful shell with advanced scripting features. To use the Zsh configuration, copy the `.zshrc` file to `~/.config/zsh/`. The .zshrc file includes several plugins and configurations that enhance the shell experience.

This README can be used in both macOS and Linux (including WSL) environments. Please adjust the installation and usage instructions as per your specific configurations.
