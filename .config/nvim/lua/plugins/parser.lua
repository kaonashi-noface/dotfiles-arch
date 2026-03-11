
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter")
        .install(
            "c",
            "jq",
            "zsh",
            "lua",
            "rust",
            "cpp",
            "fish",
            "css",
            "html",
            "json",
            "json5",
            -- "python",
            "regex",
            -- "java",
            "sql",
            "jsx",
            "tsx",
            "svelte",
            "javascript",
            "typescript"
        )
    end
}

