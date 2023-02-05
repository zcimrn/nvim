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
