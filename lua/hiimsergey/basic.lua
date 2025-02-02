local o = vim.opt

-- line numbers
o.number = true
o.relativenumber = true

-- tabs
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

-- wrap
o.wrap = true
o.linebreak = true

-- colors
-- local function transparent_bg()
--     vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none", bg = "none" })
-- end
-- vim.api.nvim_create_autocmd("ColorScheme", { callback = transparent_bg })
vim.cmd.colorscheme "catppuccin-mocha"

-- backups
o.swapfile = false
o.backup = false

-- scrolloff
o.scrolloff = 29

-- rulers
o.colorcolumn = { 80, 90 }

-- For some reason, nvim autoformats Zig code out of the box.
-- This disables it.
vim.g.zig_fmt_autosave = 0
