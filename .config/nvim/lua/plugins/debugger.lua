
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
        "mason-org/mason.nvim",
    },
    opts = {},
    config = function()
        local dap = require("dap")
        local dapui = require("dapui").setup()
        require("mason").setup()
        
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        require("nvim-dap-virtual-text").setup()

        local registry = require("mason-registry")
        require("configs.dap.node").setup(dap, registry)

    end
}

