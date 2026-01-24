vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.expandtab = true
vim.opt.smarttab = false

vim.opt.number = true
vim.opt.list = true
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.colorcolumn = "81,121"

vim.opt.termguicolors = false

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
            "ellisonleao/gruvbox.nvim",
            priority = 1000,
            lazy = false,
            opts = {
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
            },
        },
        {
            "Mofiqul/vscode.nvim",
            priority = 1000,
            lazy = false,
        },
        {
            "Mofiqul/adwaita.nvim",
            priority = 1000,
            lazy = false,
        },
        {
            "projekt0n/github-nvim-theme",
            priority = 1000,
            lazy = false,
        },
        {
            "NLKNguyen/papercolor-theme",
            priority = 1000,
            lazy = false,
        },
        {
            "folke/tokyonight.nvim",
            priority = 1000,
            lazy = false,
        },
        {
            "catppuccin/nvim",
            priority = 1000,
            lazy = false,
        },
        {
            "rebelot/kanagawa.nvim",
            priority = 1000,
            lazy = false,
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
            dependencies = {
                {
                    "nvim-treesitter/nvim-treesitter-textobjects",
                    branch = "main",
                    keys = {
                        { "if", function() require "nvim-treesitter-textobjects.select".select_textobject(
                            "@function.inner", "textobjects") end, mode = { "x", "o" } },
                        { "af", function() require "nvim-treesitter-textobjects.select".select_textobject(
                            "@function.outer", "textobjects") end, mode = { "x", "o" } },
                        { "ic", function() require "nvim-treesitter-textobjects.select".select_textobject("@class.inner",
                                "textobjects") end, mode = { "x", "o" } },
                        { "ac", function() require "nvim-treesitter-textobjects.select".select_textobject("@class.outer",
                                "textobjects") end, mode = { "x", "o" } },
                        { "ia", function() require "nvim-treesitter-textobjects.select".select_textobject(
                            "@parameter.inner", "textobjects") end, mode = { "x", "o" } },
                        { "aa", function() require "nvim-treesitter-textobjects.select".select_textobject(
                            "@parameter.outer", "textobjects") end, mode = { "x", "o" } },
                        { "ib", function() require "nvim-treesitter-textobjects.select".select_textobject("@block.inner",
                                "textobjects") end, mode = { "x", "o" } },
                        { "ab", function() require "nvim-treesitter-textobjects.select".select_textobject("@block.outer",
                                "textobjects") end, mode = { "x", "o" } },
                    },
                },
            },
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
                    "clangd",
                    "jsonls",
                    "lua_ls",
                    "yamlls",
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
vim.cmd("colorscheme vscode")

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
