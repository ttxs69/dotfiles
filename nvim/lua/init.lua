-- open line number for vim
vim.opt.number = true
-- show relative line number

-- disable highlight search
vim.opt.hlsearch = false
-- set the tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- set up copy and paste with system clipboard
vim.keymap.set({'n', 'x'}, 'gy', '"+y')
vim.keymap.set({'n', 'x'}, 'gp', '"+p')

require("config.lazy")


