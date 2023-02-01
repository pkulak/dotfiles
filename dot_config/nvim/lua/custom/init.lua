-- set up formatters for XML and JSON
local options = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', '=j', ':%!python -m json.tool<CR>:set syntax=json<CR>', options)

vim.api.nvim_set_keymap('n', '=x', ':%!python -c \'import sys;import xml.dom.minidom;s=sys.stdin.read();print(xml.dom.minidom.parseString(s).toprettyxml())\'<CR>:set syntax=xml<CR>', options)

-- use our own options
local opt = vim.opt

opt.clipboard = "unnamed"
