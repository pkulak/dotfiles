-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- set up formatters for XML and JSON
local options = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "=j", ":%!python -m json.tool<CR>:set syntax=json<CR>", options)

vim.api.nvim_set_keymap(
  "n",
  "=x",
  ":%!python -c 'import sys;import xml.dom.minidom;s=sys.stdin.read();print(xml.dom.minidom.parseString(s).toprettyxml())'<CR>:set syntax=xml<CR>",
  options
)

-- and some general options
vim.opt.timeoutlen = 1000
vim.opt.colorcolumn = "120"
vim.opt.clipboard = "unnamed"
