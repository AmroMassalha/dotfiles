# Dotfiles for macOS

This repository contains my personal dotfiles for various applications and scripts I use on macOS, managed through Git to easily replicate my setup on any new machine.

## Contents

- `nvim/` - Configurations for Neovim.
- `other_app_config/` - Configurations for other applications stored in `.config`.
- `script_name` - Executable scripts from `~/bin`.
- `tmux.conf` - Configuration for tmux session manager.
- `zshrc` - Configuration for Zsh shell.

## Prerequisites

Before cloning and using these dotfiles, ensure the following tools are installed:

- **Git**: Essential for cloning the repository and version control.
- **Homebrew**: Used to install other necessary software on macOS.

## Installation

### Step 1: Clone the Repository

Clone this repository to your local machine to get started:

```bash
git clone https://your-repo-url/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Step 2: Link Dotfiles

Use symbolic links to link the dotfiles to their appropriate locations. This allows you to keep the files in the repository but use them as if they were in their required locations:

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/other_app_config ~/.config/other_app_config
ln -s ~/dotfiles/script_name ~/bin/script_name
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/zshrc ~/.zshrc
```

### Step 3: Install Homebrew Packages

Reinstall all the Homebrew packages and casks from the backup files:

```bash
xargs brew install < brew_packages.txt
xargs brew install --cask < brew_casks.txt
```

## Customization

You are encouraged to modify and personalize the configurations as needed. Directly edit any file in the repository, and commit the changes to keep track of your modifications.

## Backup and Restore

To keep your Homebrew packages and casks up-to-date in the backup files, use the following commands:

```bash
brew list --formula > brew_packages.txt
brew list --cask > brew_casks.txt
```

Restore your Homebrew packages on a new system with:

```bash
xargs brew install < brew_packages.txt
xargs brew install --cask < brew_casks.txt
```

## Contributing

Contributions are welcome! Please fork the repository, make your changes, and submit a pull request.

## License

This project is open-sourced under the MIT License. See the LICENSE file for more details.

### Notes:

- **Repository URL**: Replace `https://your-repo-url/dotfiles.git` with the actual URL of your repository.
- **Customization and Setup**: Ensure that the paths and names used match your actual configurations.
- **License and Contributions**: Modify the sections on contributing and licensing according to your preferences or governance standards.

This README provides a structured guide to manage your configurations effectively using Git, with a clear path for setup and ongoing management. Adjust any part of this template to better fit your specific needs or personal preferences.
