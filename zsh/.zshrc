PURE_PROMPT_SYMBOL="↪ "
PURE_GIT_PULL=0
PURE_GIT_UNTRACKED_DIRTY=0
FZF_DEFAULT_COMMAND="rg --files"

source ~/.config/zsh/.zsh/history.plugin.zsh
source ~/.config/zsh/.zsh/completion.plugin.zsh
source ~/.config/zsh/.zsh/systemd.plugin.zsh
source ~/.config/zsh/.zsh/utils.plugin.zsh
source ~/.config/zsh/.zsh/python.plugin.zsh
source ~/.config/zsh/.zsh/aliases.plugin.zsh
source ~/.config/zsh/.zsh/vi-keybindings.plugin.zsh
source ~/.config/zsh/.zsh/git.plugin.zsh
source ~/.config/zsh/.zsh/fzy.zsh
source ~/.config/zsh/.zshrc.local

source ~/.config/zsh/.zsh/async.zsh
source ~/.config/zsh/.zsh/zsh-history-substring-search.zsh
source ~/.config/zsh/.zsh/pure.zsh

[ -f ~/.zshrc.secret ] && source ~/.zshrc.secret

[ -f ~/.dircolors ] && eval $(dircolors ~/.dircolors)
eval "$(lua ~/.config/zsh/.zsh/z.lua --init zsh once enhanced fzf)"
