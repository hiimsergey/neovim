-- bootstrap lazy.nvim if I lose the nvim share folder
vim.keymap.set("n", "<leader>bl", function()
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim",
        "--branch=stable",
        vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
    }
    print "Installed lazy.nvim"
end)

require "hiimsergey.lazy"
require "hiimsergey.basic"
require "hiimsergey.keys"
