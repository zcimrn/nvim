vim.opt.number = true
vim.opt.listchars = "tab:\\u25b8 ,trail:-,nbsp:+"
vim.opt.list = true
vim.opt.scrolloff = 10
vim.opt.cursorline = true
vim.opt.colorcolumn = "81,121"

vim.opt.termguicolors = false

vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

local indent_augroup_id = vim.api.nvim_create_augroup("indent", {})
vim.api.nvim_create_autocmd("FileType", {
    group = indent_augroup_id,
    callback = function()
        local filetype_to_settings_map = {
            make = {
                tabstop = 4,
                shiftwidth = 4,
                expandtab = false,
            },
            go = {
                tabstop = 4,
                shiftwidth = 4,
                expandtab = false,
            },
        }

        local settings = filetype_to_settings_map[vim.opt.filetype:get()] or {
            tabstop = 4,
            shiftwidth = 4,
            expandtab = true,
        }

        vim.opt.tabstop = settings.tabstop
        vim.opt.shiftwidth = settings.shiftwidth
        vim.opt.expandtab = settings.expandtab
    end,
})

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazy_path,
    })
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
    spec = {
        {
            "projekt0n/github-nvim-theme",
        },
        {
            "Mofiqul/vscode.nvim",
        },
        {
            "NLKNguyen/papercolor-theme",
        },
        {
            "ellisonleao/gruvbox.nvim",
            opts = {
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
            }
        },
        {
            "folke/snacks.nvim",
            opts = {
                explorer = { enabled = true },
                picker = { enabled = true },
            },
            priority = 1000,
            lazy = false,
            keys = {
                { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
                { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
                { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
                { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
                { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notifications" },
                { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },

                { "gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP definitions" },
                { "gD", function() Snacks.picker.lsp_declarations() end, desc = "LSP declarations" },
                { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP references" },
                { "gI", function() Snacks.picker.lsp_implementations() end, desc = "LSP implementations" },
                { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP type definitions" },
                { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP symbols" },
                { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP workspace symbols" },
            }
        },
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            build = ":TSUpdate",
        },
        {
            "mason-org/mason-lspconfig.nvim",
            dependencies = {
                {
                    "mason-org/mason.nvim",
                    opts = {},
                },
                "neovim/nvim-lspconfig",
            },
            opts = {
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                },
            },
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {},
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        },
    },
})

vim.opt.background = "light"
vim.cmd("colorscheme github_light")

require("nvim-treesitter").install({
    "bash",
    "c",
    "cpp",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "python",
    "rust",
    "yaml",
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            format = {
                defaultConfig = {
                    quote_style = "double",
                    max_line_length = "120",
                    align_array_table = "false",
                },
            },
        },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "LSP format" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP rename" })
