local c = vim.cmd
local function n(keys, cmd) vim.keymap.set("n", keys, cmd) end
local function i(keys, cmd) vim.keymap.set("i", keys, cmd) end

vim.g.mapleader = " "

-- editing
i("<m-bs>", "<c-w>") -- delete words with alt-backspace
i("<c-z>", c.undo)
i("<c-y>", c.redo)
i("<m-i>", "<esc>")
n("<esc>", c.nohlsearch)
i("<m-s-d>", function()
    local date = os.date("%Y-%m-%d")
    vim.api.nvim_put({date}, "c", true, true)
end)

-- saving
n("<leader><leader>", c.write)
n("<leader>z", c.wq)
n("<leader>q", ":q!<cr>")

-- commands
n("!", ":!")

-- buffers
n("<leader>x", c.bdelete)
n("<tab>", c.bnext)
n("<s-tab>", c.bprev)

-- panes
for _, d in ipairs { "h", "j", "k", "l" } do
    vim.keymap.set({ "n", "i" }, "<m-" .. d .. ">", function()
        c.wincmd(d)
    end)
end

n("<leader>j", function()
    c.split()
    c.wincmd "j"
end)

n("<leader>l", function()
    c.vsplit()
    c.wincmd "l"
end)

n("<m-<>", function() vim.cmd "vertical resize -8" end) -- resizing panes
n("<m-s-<>", function() vim.cmd "vertical resize +8" end)
n("<m-->", function() vim.cmd "resize -4" end)
n("<m-+>", function() vim.cmd "resize +4" end)

-- files
for _, file in ipairs { "basic", "keys", "lazy" } do
    n("<leader>n" .. file:sub(1, 1), function()
        c.edit("~/.config/nvim/lua/hiimsergey/" .. file .. ".lua")
    end)
end

n("<leader>cf", function() c.edit "~/.config/fish/config.fish" end)
n("<leader>cs", function() c.edit "~/.config/sway/config" end)

-- neotree
n("<leader>e", function() c.Neotree "toggle" end)

-- telescope
n("<leader>f", function() c.Telescope("find_files", "hidden=true") end)
n("<leader>g", function() c.Telescope "git_commits" end)
n("<leader>b", function() c.Telescope "buffers" end)

-- vimwiki
i("<c-8>", "[[]]<left><left>") -- links
i("<m-0>", "==<left>") -- headings
n("<leader>a", function() c.edit "~/stuff/vimwiki/Aufgaben.wiki" end)
n("<leader>d", function() c.edit "~/stuff/vimwiki/Pakete.wiki" end)
n("<leader>m", function() c.edit "~/stuff/vimwiki/main.wiki" end)
n("<leader>o", function() c.Telescope("find_files", "cwd=~/stuff/vimwiki") end)
n("<leader>p", function() c.edit "~/stuff/vimwiki/Programmieren.wiki" end)
n("<leader>u", function() c.edit "~/stuff/vimwiki/Uni.wiki" end)
n("<leader>t", function() c.edit "~/stuff/vimwiki/Tag.wiki" end)
n("<leader>w", function() c.Telescope("find_files", "cwd=~/stuff/writing") end)
n("<leader>vb", c.VimwikiBacklinks)
n("<leader>vd", c.VimwikiDeleteFile)
n("<leader>vr", c.VimwikiRenameFile)
vim.keymap.set({ "n", "i" }, "<c-m-->", c.VimwikiToggleListItem)
