require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'overcache/NeoSolarized'
end)

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    }
}
