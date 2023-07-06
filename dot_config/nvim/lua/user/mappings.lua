-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    ["=j"] = { ":%!nix-shell -p jq --run jq<CR>:set syntax=json<CR>", desc = "Format JSON" },
    ["=x"] = { ":%!nix-shell -p libxml2 --run \"xmllint --format -\"<CR>:set syntax=xml<CR>", desc = "Format XML" },
    ["gb"] = { ":buffer #<cr>", desc = "Go to last buffer" },
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- save all
    ["<leader>w"] = { ":wa<cr>", desc = "Save All" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
