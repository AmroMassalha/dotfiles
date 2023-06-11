# zmodload zsh/zprof

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/sudo"
plug "zap-zsh/vim"
plug "zap-zsh/exa"
plug "chrishrb/zsh-kubectl"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/fzf" 
plug "Aloxaf/fzf-tab"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Ensure terminal colorts work inside tmux
if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

# Start interactive shell sessions with a greeting
neofetch

# Enable FZF Tab completion
# Check if the function exists before enabling it
if typeset -f enable-fzf-tab > /dev/null; then
    enable-fzf-tab
fi

set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"

# Import zsh custumes aliases 
if [ -f $HOME/.config/zsh/config/zsh_aliases ]; then
  . $HOME/.config/zsh/config/zsh_aliases
fi

# zprof
