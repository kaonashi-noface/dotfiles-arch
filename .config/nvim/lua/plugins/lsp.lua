
return {
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            {
                "mason-org/mason.nvim",
                opts = {}
            },
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "svelte",
                -- "pyright",
                -- "gopls",
                -- "clang",
                "rust_analyzer",
                -- "java_language_server",
            },
        },
    },
    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {},
        config = function()
            require("lspsaga")
            .setup({
                lightbulb = {
                    enable = false,
                }
            })
        end
    },
}

