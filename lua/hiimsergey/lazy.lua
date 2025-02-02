local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require "lazy".setup {
    -- norsu
    {
        "hiimsergey/norsu",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            local list_wikis = require "norsu.list_wikis"
            require "norsu".setup {
                list_wikis_func = list_wikis.telescope,
                wikis = {
                    {
                        name = "basic",
                        path = vim.fn.expand("~") .. "/stuff/norsu"
                    },
                    {
                        name = "writing",
                        path = vim.fn.expand("~") .. "/stuff/writing"
                    }
                }
            }
        end
    },

    -- colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function() vim.cmd.colorscheme "catppuccin-mocha" end
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require "lualine".setup {
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    disabled_filetypes = { "neo-tree" }
                }
            }
        end
    },

    -- neotree
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "muniftanjim/nui.nvim"
        },
        config = function()
            require "neo-tree".setup {
                default_components_configs = {
                    file_size = {
                        enabled = true,
                        required_width = 10
                    }
                },
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_gitignored = false
                    }
                }
            }
        end
    },

    -- lsp
    {
        "vonheikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "l3mon4d3/luasnip",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lsp = require "lsp-zero"
            local cmp = require "cmp"
            local cmp_action = lsp.cmp_action()

            lsp.on_attach(function(_, bufnr)
                -- TODO PLAN
                -- keybeendings
                -- next/prev placeholder in a snippet
                lsp.default_keymaps { buffer = bufnr }
            end)

            cmp.setup {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" }
                },
                mapping = cmp.mapping.preset.insert {
                    ["<tab>"] = cmp_action.luasnip_jump_forward(),
                    ["<s-tab>"] = cmp_action.luasnip_jump_backward()
                }
            }

            require "mason".setup()
            require "mason-lspconfig".setup {
                ensure_installed = { "clangd" },
                handlers = {
                    function(server) require "lspconfig"[server].setup {} end
                }
            }
        end
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require "nvim-treesitter.configs".setup {
                ensure_installed = { "c", "lua", "rust", "vimdoc" },
                highlight = { enable = true },
                indent = { enable = true }
            }
        end
    },

    -- auto-pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },

    -- colorizer
    "norcalli/nvim-colorizer.lua",

    -- vimwiki
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
    }
}
