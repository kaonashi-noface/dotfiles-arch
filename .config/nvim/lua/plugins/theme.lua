math.randomseed(os.time())
local asciiFiles = {
    "koboni",
    "makima",
    "momo",
    "raze"
}



return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = {
                    light = "frappe",
                    dark = "mocha",
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end
    },
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-mini/mini.icons" },
        config = function ()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            asciiArtName = asciiFiles[math.random(#asciiFiles)]
            asciiConfig = require("resources." .. asciiArtName)
            dashboard.section.header.val = asciiConfig.val
            dashboard.section.header.opts = asciiConfig.opts
            alpha.setup(dashboard.opts)
        end
    }
}


