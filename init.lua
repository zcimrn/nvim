vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.smarttab = true
        vim.opt.autoindent = true
        vim.opt.smartindent = true

        if vim.o.filetype == 'cpp' then
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            return
        end
    end,
})

vim.opt.number = true
vim.opt.listchars = 'tab:\\u25b8 ,trail:-,nbsp:+'
vim.opt.list = true
vim.opt.scrolloff = 8

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

require('packer').startup(function(use)
    use('wbthomason/packer.nvim')
    use('neovim/nvim-lspconfig')
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-tree/nvim-tree.lua')
    use({ 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' })
    use('nvim-lualine/lualine.nvim')
    use('Mofiqul/vscode.nvim')
end)

require('lspconfig').clangd.setup({
    cmd = {'clangd', '--background-index', '-j=16'}
})

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

require('nvim-treesitter.configs').setup({
     ensure_installed = {
        'vim',
        'vimdoc',
        'lua',
        'bash',
        'c',
        'cpp',
        'go',
        'python',
        'javascript',
    },
    ignore_install = {'all'},
    highlight = { enable = true },
    indent = { enable = true },
})

require('nvim-tree').setup({})

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

require('lualine').setup({
    icons_enabled = true,
})

require('vscode').load()
