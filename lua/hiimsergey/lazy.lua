local vim = vim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim for if i lose the nvim share directory
vim.keymap.set("n", "<leader>bl", function()
    print "Installing lazy.nvim..."
    local stat = vim.fn.system {
        "git", "clone", "--filter=blob:none", "--depth=1",
        "https://github.com/folke/lazy.nvim",
        lazypath
    }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { stat, "WarningMsg" },
            { "\nPress any key to exit..." }
        }, true, {})
        return
    end
    print "Installed lazy.nvim successfully! Please restart nvim!"
end)

vim.opt.rtp:prepend(lazypath)

require "lazy".setup {
    "marko-cerovac/material.nvim",
    "olimorris/onedarkpro.nvim",
    "projekt0n/github-nvim-theme",
    "sainnhe/gruvbox-material",
    "tiagovla/tokyodark.nvim",
    { "catppuccin/nvim", name = "catppuccin" },
    { "rose-pine/neovim", name = "rose-pine" },

    {
        "hiimsergey/norsu.nvim",
        config = function()
            require "norsu".setup {
                wikis = {
                    { name = "basic", path = "~/stuff/basic" },
                    { name = "writing", path = "~/stuff/writing" }
                }
            }
        end
    },

    {
        "vimwiki/vimwiki",
        init = function()
            vim.g.vimwiki_list = {
                {
                    path = "~/stuff/vimwiki",
                    index = "main"
                }
            }
        end
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local telescope = require "telescope"
            local actions = require "telescope.actions"
            telescope.setup {
                defaults = { mappings = { i = { ["<esc>"] = actions.close } } },
                pickers = { colorscheme = { theme = "dropdown" } },
                extensions = {
                    file_browser = {
                        hidden = true,
                        hijack_netrw = true
                    },
                }
            }
            telescope.load_extension "file_browser"
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require "nvim-treesitter.configs".setup {
                ensure_installed = { "lua", "vimdoc" },
                highlight = { enable = true },
                indent = { enable = true }
            }
        end
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.opt.signcolumn = "yes"
            local lspconfig = require "lspconfig"
            lspconfig.clangd.setup {}
            lspconfig.lua_ls.setup {}
            lspconfig.ts_ls.setup {}
            lspconfig.zls.setup {}
        end
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = "hrsh7th/cmp-nvim-lsp",
        config = function()
            local cmp = require "cmp"
            cmp.setup {
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind_icons = {
                            Text = "", Method = "󰆧", Function = "󰊕", Constructor = "",
                            Field = "󰇽", Variable = "󰂡", Class = "󰠱", Interface = "",
                            Module = "", Property = "󰜢", Unit = "", Value = "󰎠",
                            Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
                            File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "",
                            Constant = "󰏿", Struct = "", Event = "", Operator = "󰆕",
                            TypeParameter = "󰅲",
                        }

                        vim_item.kind = string.format(
                            "%s %s",
                            kind_icons[vim_item.kind],
                            vim_item.kind
                        )
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Lua]"
                        })[entry.source.name]
                        return vim_item
                    end
                },
                mapping = cmp.mapping.preset.insert {
                    ["<c-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<c-d>"] = cmp.mapping.scroll_docs(4),
                    ["<c-space>"] = cmp.mapping.complete(),
                    ["<c-x>"] = cmp.mapping.abort(),
                    ["<cr>"] = cmp.mapping.confirm { select = true }
                },
                snippet = { expand = function(args) vim.snippet.expand(args.body) end },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" }
                },
                view = { entries = "native" },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
            }

            -- necessary to make clangd completions not suck
            local capabilities = require "cmp_nvim_lsp".default_capabilities()
            require "lspconfig".clangd.setup { capabilities = capabilities }
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require "lualine".setup {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '│', right = '│' }
                },
                sections = {
                    lualine_z = {
                        "location",
                        {
                            function() return vim.wo.wrap and "wrap" or "" end,
                            icon = "󰖶",
                            color = "@comment.todo"
                        },
                        {
                            function() return vim.g.colorizer and "colorizer" or "" end,
                            icon = "",
                            color = "@comment.warning"
                        },
                    }
                }
            }
        end
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },

    "norcalli/nvim-colorizer.lua",

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            icons = { mappings = false },
            delay = 300
        }
    },

    {
        "junegunn/goyo.vim",
        init = function()
            vim.g.goyo_width = 90
            vim.g.goyo_height = 100
            vim.g.goyo_linenr = true
        end
    }
}
