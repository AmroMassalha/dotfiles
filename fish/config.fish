set fish_greeting ""

set -gx TERM xterm-256color

eval "$(/opt/homebrew/bin/brew shellenv)"
# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always


### "nvim" as manpager
set -x MANPAGER "nvim +Man!"
set -x EDITOR nvim
set -x AWS_PROFILE icvt

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git

alias k "kubecolor"
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

source (dirname (status --current-filename))/config-osx.fish

colorscript random

eval "$(oh-my-posh init fish --config ~/dotfiles/ohmyposh_base.toml)"

