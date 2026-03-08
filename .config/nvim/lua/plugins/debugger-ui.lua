
return {
    "mfussenegger/nvim-dap",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text"
        },
        opts = {},
        config = function()
            require("dapui").setup()
            require("nvim-dap-virtual-text").setup()
        end
    }
}

