vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.shiftround = true
vim.opt.softtabstop = -1
vim.opt.smarttab = false
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.list = true
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.colorcolumn = "81,121"

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim",
        lazy_path,
    })
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
    spec = {
        { "artart222/nvim-enfocado", lazy = false, priority = 1000 },
        { "calind/selenized.nvim", lazy = false, priority = 1000 },
        { "catppuccin/nvim", lazy = false, priority = 1000 },
        { "EdenEast/nightfox.nvim", lazy = false, priority = 1000 },
        { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
        { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
        { "kepano/flexoki-neovim", lazy = false, priority = 1000 },
        { "MarcoKorinth/onehalf.nvim", lazy = false, priority = 1000 },
        { "Mofiqul/adwaita.nvim", lazy = false, priority = 1000 },
        { "Mofiqul/vscode.nvim", lazy = false, priority = 1000 },
        { "navarasu/onedark.nvim", lazy = false, priority = 1000 },
        { "neanias/everforest-nvim", lazy = false, priority = 1000 },
        { "nlknguyen/papercolor-theme", lazy = false, priority = 1000 },
        { "projekt0n/github-nvim-theme", lazy = false, priority = 1000 },
        { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
        { "rose-pine/neovim", lazy = false, priority = 1000 },
        { "Shatur/neovim-ayu", lazy = false, priority = 1000 },
        { "talha-akram/noctis.nvim", lazy = false, priority = 1000 },
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" } },
            build = function()
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
            end,
        },
        -- {
        --     "folke/snacks.nvim",
        --     lazy = false,
        --     priority = 1000,
        --     keys = {
        --         { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
        --         { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        --         { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
        --         { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },
        --         { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notifications" },
        --         { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
        --
        --         { "gd", function() Snacks.picker.lsp_definitions() end, desc = "LSP definitions" },
        --         { "gD", function() Snacks.picker.lsp_declarations() end, desc = "LSP declarations" },
        --         { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP references" },
        --         { "gI", function() Snacks.picker.lsp_implementations() end, desc = "LSP implementations" },
        --         { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP type definitions" },
        --         { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP symbols" },
        --         { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP workspace symbols" },
        --     },
        --     opts = {
        --         explorer = { enabled = true },
        --         picker = { enabled = true },
        --     },
        -- },
        {
            "mason-org/mason-lspconfig.nvim",
            dependencies = {
                { "mason-org/mason.nvim", opts = {} },
                "neovim/nvim-lspconfig",
            },
            opts = {
                ensure_installed = {
                    "basedpyright",
                    "clangd",
                    "jsonls",
                    "lua_ls",
                    "ruff",
                    "stylua",
                    "yamlls",
                },
            },
        },
        { "folke/lazydev.nvim", ft = "lua", opts = {} },
        { "folke/which-key.nvim", event = "VeryLazy" },
        {
            "lewis6991/gitsigns.nvim",
            opts = {
                on_attach = function(buffer)
                    local gitsigns = require("gitsigns")

                    vim.keymap.set({"x", "o"}, "ih", gitsigns.select_hunk,
                        { buffer = buffer, desc = "inner hunk" })
                    vim.keymap.set({"x", "o"}, "ah", gitsigns.select_hunk,
                        { buffer = buffer, desc = "outer hunk" })

                    vim.keymap.set({"n", "x", "o"}, "]h", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]h", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end, { buffer = buffer, desc = "next hunk" })

                    vim.keymap.set({"n", "x", "o"}, "[h", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[h", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end, { buffer = buffer, desc = "previous hunk" })

                    vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk,
                        { buffer = buffer, desc = "preview hunk" })
                    vim.keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline,
                        { buffer = buffer, desc = "preview hunk inline" })

                    vim.keymap.set("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                        { buffer = buffer, desc = "stage hunk lines" })
                    vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk,
                        { buffer = buffer, desc = "stage hunk" })
                    vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer,
                        { buffer = buffer, desc = "stage buffer hunks" })

                    vim.keymap.set("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                        { buffer = buffer, desc = "reset hunk lines" })
                    vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk,
                        { buffer = buffer, desc = "reset hunk" })
                    vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer,
                        { buffer = buffer, desc = "reset hunk" })

                    vim.keymap.set("n", "<leader>hq", gitsigns.setqflist,
                        { buffer = buffer, desc = "buffer hunks" })
                    vim.keymap.set("n", "<leader>hQ", function() gitsigns.setqflist("all") end,
                        { buffer = buffer, desc = "all hunks" })

                    vim.keymap.set("n", "<leader>hd", gitsigns.diffthis,
                        { buffer = buffer, desc = "diff" })

                    vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end,
                        { buffer = buffer, desc = "blame" })
              end
            }
        },
    },
})

vim.opt.background = "light"
vim.cmd.colorscheme("flexoki")

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            format = { enable = false },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
    },
})

vim.lsp.config("stylua", { cmd = { "stylua", "--lsp", "--indent-type", "Spaces", "--quote-style", "ForceDouble", "--sort-requires"} })

local function select_textobject(query_string, query_group)
    return function()
        require("nvim-treesitter-textobjects.select").select_textobject(query_string, query_group or "textobjects")
    end
end

vim.keymap.set({ "x", "o" }, "ib", select_textobject("@block.inner"), { desc = "inner block" })
vim.keymap.set({ "x", "o" }, "ab", select_textobject("@block.outer"), { desc = "outer block" })

vim.keymap.set({ "x", "o" }, "if", select_textobject("@call.inner"), { desc = "inner call" })
vim.keymap.set({ "x", "o" }, "af", select_textobject("@call.outer"), { desc = "outer call" })

vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"), { desc = "inner class" })
vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"), { desc = "outer class" })

vim.keymap.set({ "x", "o" }, "ii", select_textobject("@conditional.inner"), { desc = "inner conditional" })
vim.keymap.set({ "x", "o" }, "ai", select_textobject("@conditional.outer"), { desc = "outer conditional" })

vim.keymap.set({ "x", "o" }, "im", select_textobject("@function.inner"), { desc = "inner function" })
vim.keymap.set({ "x", "o" }, "am", select_textobject("@function.outer"), { desc = "outer function" })

vim.keymap.set({ "x", "o" }, "il", select_textobject("@loop.inner"), { desc = "inner loop" })
vim.keymap.set({ "x", "o" }, "al", select_textobject("@loop.outer"), { desc = "outer loop" })

vim.keymap.set({ "x", "o" }, "ia", select_textobject("@parameter.inner"), { desc = "inner parameter" })
vim.keymap.set({ "x", "o" }, "aa", select_textobject("@parameter.outer"), { desc = "outer parameter" })

vim.keymap.set({ "x", "o" }, "ir", select_textobject("@return.inner"), { desc = "inner return" })
vim.keymap.set({ "x", "o" }, "ar", select_textobject("@return.outer"), { desc = "outer return" })

vim.keymap.set({ "x", "o" }, "ax", select_textobject("@statement.outer"), { desc = "outer statement" })

vim.keymap.set({ "x", "o" }, "as", select_textobject("@local.scope", "locals"), { desc = "outer scope" })

vim.keymap.set("n", "<leader>a", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end)
vim.keymap.set("n", "<leader>A", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer") end)

local function goto_next_start(query_string, query_group)
    return function()
        require("nvim-treesitter-textobjects.move").goto_next_start(query_string, query_group or "textobjects")
    end
end

local function goto_next_end(query_string, query_group)
    return function()
        require("nvim-treesitter-textobjects.move").goto_next_end(query_string, query_group or "textobjects")
    end
end

local function goto_previous_start(query_string, query_group)
    return function()
        require("nvim-treesitter-textobjects.move").goto_previous_start(query_string, query_group or "textobjects")
    end
end

local function goto_previous_end(query_string, query_group)
    return function()
        require("nvim-treesitter-textobjects.move").goto_previous_end(query_string, query_group or "textobjects")
    end
end

vim.keymap.set({ "n", "x", "o" }, "]b", goto_next_start("@block.outer"), { desc = "next block start" })
vim.keymap.set({ "n", "x", "o" }, "]B", goto_next_end("@block.outer"), { desc = "next block end" })
vim.keymap.set({ "n", "x", "o" }, "[b", goto_previous_start("@block.outer"), { desc = "previous block start" })
vim.keymap.set({ "n", "x", "o" }, "[B", goto_previous_end("@block.outer"), { desc = "previous block end" })

vim.keymap.set({ "n", "x", "o" }, "]f", goto_next_start("@call.outer"), { desc = "next call start" })
vim.keymap.set({ "n", "x", "o" }, "]F", goto_next_end("@call.outer"), { desc = "next call end" })
vim.keymap.set({ "n", "x", "o" }, "[f", goto_previous_start("@call.outer"), { desc = "previous call start" })
vim.keymap.set({ "n", "x", "o" }, "[F", goto_previous_end("@call.outer"), { desc = "previous call end" })

vim.keymap.set({ "n", "x", "o" }, "]c", goto_next_start("@class.outer"), { desc = "next class start" })
vim.keymap.set({ "n", "x", "o" }, "]C", goto_next_end("@class.outer"), { desc = "next class end" })
vim.keymap.set({ "n", "x", "o" }, "[c", goto_previous_start("@class.outer"), { desc = "previous class start" })
vim.keymap.set({ "n", "x", "o" }, "[C", goto_previous_end("@class.outer"), { desc = "previous class end" })

vim.keymap.set({ "n", "x", "o" }, "]i", goto_next_start("@conditional.outer"), { desc = "next conditional start" })
vim.keymap.set({ "n", "x", "o" }, "]I", goto_next_end("@conditional.outer"), { desc = "next conditional end" })
vim.keymap.set({ "n", "x", "o" }, "[i", goto_previous_start("@conditional.outer"), { desc = "previous conditional start" })
vim.keymap.set({ "n", "x", "o" }, "[I", goto_previous_end("@conditional.outer"), { desc = "previous conditional end" })

vim.keymap.set({ "n", "x", "o" }, "]m", goto_next_start("@function.outer"), { desc = "next function start" })
vim.keymap.set({ "n", "x", "o" }, "]M", goto_next_end("@function.outer"), { desc = "next function end" })
vim.keymap.set({ "n", "x", "o" }, "[m", goto_previous_start("@function.outer"), { desc = "previous function start" })
vim.keymap.set({ "n", "x", "o" }, "[M", goto_previous_end("@function.outer"), { desc = "previous function end" })

vim.keymap.set({ "n", "x", "o" }, "]l", goto_next_start("@loop.outer"), { desc = "next loop start" })
vim.keymap.set({ "n", "x", "o" }, "]L", goto_next_end("@loop.outer"), { desc = "next loop end" })
vim.keymap.set({ "n", "x", "o" }, "[l", goto_previous_start("@loop.outer"), { desc = "previous loop start" })
vim.keymap.set({ "n", "x", "o" }, "[L", goto_previous_end("@loop.outer"), { desc = "previous loop end" })

vim.keymap.set({ "n", "x", "o" }, "]a", goto_next_start("@parameter.outer"), { desc = "next parameter start" })
vim.keymap.set({ "n", "x", "o" }, "]A", goto_next_end("@parameter.outer"), { desc = "next parameter end" })
vim.keymap.set({ "n", "x", "o" }, "[a", goto_previous_start("@parameter.outer"), { desc = "previous parameter start" })
vim.keymap.set({ "n", "x", "o" }, "[A", goto_previous_end("@parameter.outer"), { desc = "previous parameter end" })

vim.keymap.set({ "n", "x", "o" }, "]r", goto_next_start("@return.outer"), { desc = "next return start" })
vim.keymap.set({ "n", "x", "o" }, "]R", goto_next_end("@return.outer"), { desc = "next return end" })
vim.keymap.set({ "n", "x", "o" }, "[r", goto_previous_start("@return.outer"), { desc = "previous return start" })
vim.keymap.set({ "n", "x", "o" }, "[R", goto_previous_end("@return.outer"), { desc = "previous return end" })

vim.keymap.set({ "n", "x", "o" }, "]x", goto_next_start("@statement.outer"), { desc = "next statement start" })
vim.keymap.set({ "n", "x", "o" }, "]X", goto_next_end("@statement.outer"), { desc = "next statement end" })
vim.keymap.set({ "n", "x", "o" }, "[x", goto_previous_start("@statement.outer"), { desc = "previous statement start" })
vim.keymap.set({ "n", "x", "o" }, "[X", goto_previous_end("@statement.outer"), { desc = "previous statement end" })

vim.keymap.set({ "n", "x", "o" }, "]s", goto_next_start("@local.scope", "locals"), { desc = "next scope start" })
vim.keymap.set({ "n", "x", "o" }, "]S", goto_next_end("@local.scope", "locals"), { desc = "next scope end" })
vim.keymap.set({ "n", "x", "o" }, "[s", goto_previous_start("@local.scope", "locals"), { desc = "previous scope start" })
vim.keymap.set({ "n", "x", "o" }, "[S", goto_previous_end("@local.scope", "locals"), { desc = "previous scope end" })

local repeatable_move = require("nvim-treesitter-textobjects.repeatable_move")

vim.keymap.set({ "n", "x", "o" }, ";", repeatable_move.repeat_last_move, { desc = "repeate last move" })
vim.keymap.set({ "n", "x", "o" }, ",", repeatable_move.repeat_last_move_opposite, { desc = "repeate last move opposite" })

vim.keymap.set({ "n", "x", "o" }, "f", repeatable_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", repeatable_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", repeatable_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", repeatable_move.builtin_T_expr, { expr = true })

vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "LSP format" })
