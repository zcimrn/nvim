vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.shiftround = true
vim.opt.softtabstop = -1
vim.opt.smarttab = false
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.guicursor = "a:block"
vim.opt.list = true
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.colorcolumn = "81,121"
vim.opt.winborder = "rounded"
-- vim.opt.termguicolors = false

vim.opt.foldcolumn = "auto"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.spelllang = "ru_ru,en_us"

vim.opt.langmap = ""
    .. "йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],"
    .. "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},"
    .. "фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э\\',"
    .. "ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Э\\\","
    .. "яz,чx,сc,мv,иb,тn,ьm,б\\,,ю.,ё`,№#,"
    .. "ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,Ё~"

if vim.g.vscode then
    return
end

vim.pack.add({
    "https://github.com/tinted-theming/tinted-nvim",
    -- "https://github.com/Mofiqul/vscode.nvim",
    -- "https://github.com/projekt0n/github-nvim-theme",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-mini/mini.diff",
})

-- vim.cmd.colorscheme("vscode")

require("tinted-nvim").setup({
    default_scheme = "base16-selenized-white",
})

require("nvim-treesitter").install("all")

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "basedpyright",
        "clangd",
        "jsonls",
        "lua_ls",
        "ruff",
        "rust_analyzer",
        "stylua",
        "yamlls",
    },
})

require("mini.diff").setup({
    view = { style = "sign" },
})

vim.lsp.config("clangd", {
    cmd = { "clangd", "-j", "4" },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            format = { enable = false },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
    },
})

vim.lsp.config("stylua", {
    cmd = { "stylua", "--lsp", "--indent-type", "Spaces", "--quote-style", "ForceDouble", "--sort-requires" },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "LSP format" })
