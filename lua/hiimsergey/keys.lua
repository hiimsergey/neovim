local c = vim.cmd
local function n(keys, cmd) vim.keymap.set("n", keys, cmd) end
local function i(keys, cmd) vim.keymap.set("i", keys, cmd) end

vim.g.mapleader = " "

-- editing
i("<m-bs>", "<c-w>") -- delete words with alt-backspace
i("<c-z>", c.undo)
i("<c-y>", c.redo)
i("<m-i>", "<esc>")

-- saving
n("<leader><leader>", c.write)
n("<leader>z", c.wq)
n("<leader>q", ":q!<cr>")

-- buffers
n("<leader>x", c.bdelete)

-- panes
for _, pane in ipairs { "h", "j", "k", "l" } do
    vim.keymap.set({ "n", "i" }, "<m-" .. pane .. ">", function()
        c.wincmd(pane)
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

-- command line
n("!", ":!")
n("E", ":e ")

-- files
for _, file in ipairs { "basic", "keys", "lazy" } do
    n("<leader>n" .. file:sub(1, 1), function()
        c.edit("~/.config/nvim/lua/hiimsergey/" .. file .. ".lua")
    end)
end

n("<leader>ch", function() c.Telescope("find_files", "cwd=~/.config/hypr") end)
n("<leader>cf", function() c.edit "~/.config/fish/config.fish" end)

-- neotree
n("<leader>e", function() c.Neotree "toggle" end)

-- telescope
n("<leader>f", function() c.Telescope("find_files", "hidden=true") end)
n("<leader>g", function() c.Telescope "git_commits" end)
n("<leader>b", function() c.Telescope "buffers" end)

-- vimwiki
i("<c-8>", "[[]]<left><left>") -- links
i("<m-s-0>", "==<left>") -- headings
n("<leader>a", function() c.edit "~/stuff/vimwiki/Aufgaben.wiki" end)
n("<leader>d", function() c.edit "~/stuff/vimwiki/Pakete.wiki" end)
n("<leader>m", function() c.edit "~/stuff/vimwiki/main.wiki" end)
n("<leader>o", function() c.Telescope("find_files", "cwd=~/stuff/vimwiki") end)
n("<leader>p", function() c.edit "~/stuff/vimwiki/Programmieren.wiki" end)
n("<leader>u", function() c.edit "~/stuff/vimwiki/Uni.wiki" end)
n("<leader>t", function() c.edit "~/stuff/vimwiki/Tag.wiki" end)
n("<leader>wb", c.VimwikiBacklinks)
n("<leader>wd", c.VimwikiDeleteFile)
n("<leader>wr", c.VimwikiRenameFile)
vim.keymap.set({ "n", "i" }, "<c-m-->", c.VimwikiToggleListItem)
