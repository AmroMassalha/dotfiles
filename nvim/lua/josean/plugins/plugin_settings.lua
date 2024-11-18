-- Color name (:help cterm-colors) or ANSI code
-- there are some defaults for image directory and image name, you can change them
vim.g.mdip_imgdir = "_media"
vim.g.mdip_imgname = "image"
vim.g["plantuml_previewer#viewer_path"] = "~/.vim/bundle/plantuml-previewer.vim/viewer"
vim.g["plantuml_previewer#debug_mode"] = 0
vim.g["plantuml_previewer#plantuml_jar_path"] = "/usr/local/bin/plantuml.jar"
-- setup custom emmet snippets
vim.g.user_emmet_settings = "webapi#json#decode(join(readfile(expand('~/.snippets_custom.json')), \"\n\"))"
vim.g.indentLine_char = "?"
-- setup for netrw
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0
-- setup for syntastic
vim.g.syntastic_always_populate_loc_list = 0
vim.g.syntastic_auto_loc_list = 0
vim.g.syntastic_check_on_open = 0
vim.g.syntastic_check_on_wq = 0
vim.g.syntastic_python_checkers = "['flake8']"
-- setup for terraform
vim.g.terraform_fmt_on_save = 1
vim.g.terraform_align = 1
-- setup for ctrlp
vim.g.ctrlp_map = "<c-p>"
vim.g.ctrlp_cmd = "CtrlPMixed"
vim.g.ctrlp_working_path_mode = "ra"
vim.g.ctrlp_custom_ignore = "\\v[\\/]\\.(git|hg|svn)$"
vim.g.ctrlp_custom_ignore = {
  dir = { "\\v[\\/]\\.(git|hg|svn)$" },
  file = { "\\v\\.(exe|so|dll)$" },
  link = { "some_bad_symbolic_links" },
}
-- setup for indent line
vim.g.indentLine_char = "|"
vim.g.go_fmt_command = "goimports"
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_structs = 1
vim.g.go_highlight_interfaces = 1
vim.g.go_highlight_operators = 1
vim.g.go_fmt_experimental = 1
-- Send to window
vim.g.sendtowindow_use_defaults = 0
-- Scrollfix
vim.g.scrollfix = -1
vim.g.rnvimr_enable_picker = 1
-- Startify
vim.g.startify_change_to_dir = 1
vim.g.startify_session_persistence = 0
vim.g.startify_change_to_vsc_root = 1
vim.g.startify_session_number = 0
vim.g.startify_files_number = 10
vim.g.startify_session_delete_buffers = 0
vim.g.startify_skiplist = {
  "^/tmp",
}
vim.g.startify_commands = {
  { "Search Dev    :SPC fd", "Telescope find_files search_dirs=~/dev,--hidden,--with-filename" },
  { "Search Repos  :SPC fr", "lua require'telescope'.extensions.repo.list{search_dirs = {\"~/dev\"}}" },
  { "Change Color  :SPC fc", "Telescope colorscheme" },
  { "Transparent Bg:SPC tr", "TransparentEnable" },
  { "Pick Emoji    :SPC fm", "Telescope emoji" },
}
vim.g.startify_bookmarks = {
  "~/.config/nvim/lua",
  "~/.zshrc",
  "~/.tmux.conf",
  "~/.taskrc",
  "~/.task/hooks",
  "~/shortcuts.md",
  "/usr/local/share/zsh/site-functions",
  "~/dev/dotfiles/.config/nvim/lua/projects/module.lua",
  "~/scripts/__project_mappings.conf",
  "~/.taskopenrc",
  "~/.oh-my-zsh/plugins/tmuxinator/_mst",
  "~/.config/taskwarrior-tui/shortcut-scripts",
  "~/.local/share/nvim/site/pack/packer/start",
  "~/.local/share/nvim/gp/chats",
  "/etc/systemd/system/zoom-monitor.service",
}
vim.g.startify_custom_header = "startify#pad(split(system('fortune -s | cowsay | lolcat; date'), '\n'))"
