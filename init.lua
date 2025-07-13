vim.opt.number = true
vim.opt.listchars = 'tab:\\u25b8 ,trail:-,nbsp:+'
vim.opt.list = true
vim.opt.scrolloff = 10
vim.opt.cursorline = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        vim.opt.smarttab = true
        vim.opt.autoindent = true
        vim.opt.smartindent = true

        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true

        local filetype = vim.opt.filetype:get()

        if filetype == 'c' then
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.expandtab = true
        end

        if filetype == 'cpp' then
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.expandtab = true
        end

        if filetype == 'go' then
            vim.opt.tabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = false
        end

        if filetype == 'json' then
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.expandtab = true
        end

        if filetype == 'lua' then
            vim.opt.tabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
        end

        if filetype == 'make' then
            vim.opt.tabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = false
        end

        if filetype == 'py' then
            vim.opt.tabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
        end

        if filetype == 'sh' then
            vim.opt.tabstop = 4
            vim.opt.shiftwidth = 4
            vim.opt.expandtab = true
        end

        if filetype == 'yaml' then
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.expandtab = true
        end
    end,
})

-- lazy

local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazy_path,
    })
end

vim.opt.rtp:prepend(lazy_path)

require('lazy').setup({
    spec = {
        {
            'ellisonleao/gruvbox.nvim',
        },
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
        },
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
        },
        {
            'neovim/nvim-lspconfig',
        },
        {
            'folke/lazydev.nvim',
            opts = {},
            ft = 'lua',
        },
    }
})

-- colorscheme

require('gruvbox').setup({
    italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    contrast = 'hard',
})

vim.opt.termguicolors = false

-- vim.cmd('colorscheme gruvbox')

-- treesitter

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'dockerfile',
        'go',
        'html',
        'javascript',
        'json',
        'lua',
        'python',
        'vim',
        'vimdoc',
        'yaml',
    },
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
})

-- telescope

local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files)
vim.keymap.set('n', '<leader>fg', telescope.live_grep)
vim.keymap.set('n', '<leader>fb', telescope.buffers)
vim.keymap.set('n', '<leader>fh', telescope.help_tags)

-- lsp

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local opts = { buffer = ev.buf }
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
        vim.keymap.set('n', 'gD', telescope.lsp_type_definitions, opts)
        vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
        vim.keymap.set('n', 'gi', telescope.lsp_implementations, opts)

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

vim.lsp.enable('clangd')

vim.lsp.enable('lua_ls')

vim.lsp.enable('ruff')
