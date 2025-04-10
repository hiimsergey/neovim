local vim = vim
local ks = vim.keymap.set

vim.g.mapleader = " "

-- files
ks("n", "<leader>nk", function() vim.cmd.edit "~/.config/nvim/lua/hiimsergey/keys.lua" end, { desc = "Open nvim's key config" })
ks("n", "<leader>nl", function() vim.cmd.edit "~/.config/nvim/lua/hiimsergey/lazy.lua" end, { desc = "Open nvim's plugin config" })
ks("n", "<leader>no", function() vim.cmd.edit "~/.config/nvim/lua/hiimsergey/opt.lua" end, { desc = "Open nvim's basic options" })
ks("n", "<leader>cf", function() vim.cmd.edit "~/.config/fish/config.fish" end, { desc = "Open shell config" })
ks("n", "<leader>cs", function() vim.cmd.edit "~/.config/sway/config" end, { desc = "Open window manager config" })

-- writing
ks("i", "<m-backspace>", "<c-w>", { desc = "Delete last word" })
ks("n", "<leader><leader>", vim.cmd.write, { desc = "Save file" })
ks("n", "<leader>z", vim.cmd.wq, { desc = "Save and quit" })
ks("n", "<leader>q", ":q!<cr>", { desc = "Quit without saving" })
ks("n", "<leader>k", function() vim.wo.wrap = not vim.wo.wrap end, { desc = "Toggle wrap" })

-- buffers
ks("n", "<leader>x", vim.cmd.bdelete, { desc = "Close buffer" })
ks("n", "<leader><tab>", vim.cmd.bnext, { desc = "Go to next buffer" })
ks("n", "<leader><s-tab>", vim.cmd.bprev, { desc = "Go to previous buffer" })

-- lsp
ks({ "n", "i" }, "<f2>", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" })

-- panes
ks({ "n", "i" }, "<m-h>", function() vim.cmd.wincmd("h") end, { desc = "Go to pane to the left" })
ks({ "n", "i" }, "<m-j>", function() vim.cmd.wincmd("j") end, { desc = "Go to pane below" })
ks({ "n", "i" }, "<m-k>", function() vim.cmd.wincmd("k") end, { desc = "Go to pane above" })
ks({ "n", "i" }, "<m-l>", function() vim.cmd.wincmd("l") end, { desc = "Go to pane to the right" })

ks("n", "<leader>j", function()
    vim.cmd.split()
    vim.cmd.wincmd "j"
end, { desc = "Split pane down" })

ks("n", "<leader>l", function()
    vim.cmd.vsplit()
    vim.cmd.wincmd "l"
end, { desc = "Split pane to the right" })

-- resizing panes
ks("n", "<m-<>", function() vim.cmd "vertical resize -8" end, { desc = "Shrink pane vertically" })
ks("n", "<m-s-<>", function() vim.cmd "vertical resize +8" end, { desc = "Grow pane vertically" })
ks("n", "<m-->", function() vim.cmd "horizontal resize -4" end, { desc = "Shrink pane horizontally" })
ks("n", "<m-+>", function() vim.cmd "horizontal resize +4" end, { desc = "Grow pane horizontally" })

-- telescope
local telescope = require "telescope"
local builtin = require "telescope.builtin"
ks("n", "<leader>.", builtin.oldfiles, { desc = "View recent files" })
ks("n", "<leader>b", builtin.buffers, { desc = "View open buffers" })
ks("n", "<leader>e", telescope.extensions.file_browser.file_browser, { desc = "Browse files" })
ks("n", "<leader>f", builtin.find_files, { desc = "Find files in this directory" })
ks("n", "<leader>t", builtin.colorscheme, { desc = "Change colorscheme" })

-- vimwiki
ks("i", "<c-8>", "[[]]<left><left>", { desc = "Insert vimwiki link" })
ks("i", "<m-0>", "==<left>", { desc = "Insert vimwiki heading" })
ks("n", "<leader>a", function() vim.cmd.edit "~/stuff/vimwiki/Aufgaben.wiki" end, { desc = "Open tasks wiki page" })
ks("n", "<leader>d", builtin.diagnostics, { desc = "View LSP diagnostics" })
ks("n", "<leader>m", function() vim.cmd.edit "~/stuff/vimwiki/main.wiki" end, { desc = "Open main wiki page" })
ks("n", "<leader>o", function() vim.cmd.Telescope("find_files", "cwd=~/stuff/vimwiki") end, { desc = "Find wiki pages" })
ks("n", "<leader>p", function() vim.cmd.edit "~/stuff/vimwiki/Programmieren.wiki" end, { desc = "Open programming wiki page" })
ks("n", "<leader>u", function() vim.cmd.edit "~/stuff/vimwiki/Uni.wiki" end, { desc = "Open uni wiki page" })
ks("n", "<leader>w", function() vim.cmd.Telescope("find_files", "cwd=~/stuff/writing") end, { desc = "Find writing wiki pages" })
ks("n", "<leader>vb", vim.cmd.VimwikiBacklinks, { desc = "Show this wiki page's backlinks" })
ks("n", "<leader>vd", vim.cmd.VimwikiDeleteFile, { desc = "Delete this wiki page" })
ks("n", "<leader>vr", vim.cmd.VimwikiRenameFile, { desc = "Rename this wiki page" })

-- etc
ks("n", "<esc>", vim.cmd.nohlsearch, { desc = "Remove search highlights" })
ks("n", "<leader>g", vim.cmd.Goyo, { desc = "Toggle zen mode" })
ks("n", "<leader>h", function()
    vim.cmd.ColorizerToggle()
    vim.g.colorizer = not vim.g.colorizer
end, { desc = "Toggle hex colorizer" })
