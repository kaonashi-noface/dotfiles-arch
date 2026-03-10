
return {
    setup = function(dap, registry)
        registry.refresh(function()
            if not registry.has_package("js-debug-adapter") then
                return
            end

            local dapAdapterPkgPath = vim.fn.expand("$MASON/packages/js-debug-adapter")
            local jsDapServerPath = dapAdapterPkgPath .. "/js-debug/src/dapDebugServer.js"
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = { jsDapServerPath, "${port}" },
                }
            }

            for _, language in ipairs({ "typescript", "javascript" }) do
                dap.configurations[language] = {
                    {
                        name = "Debug Current File",
                        type = "pwa-node",
                        request = "launch",
                        cwd = "${workspaceFolder}",
                        program = "${file}",
                        stopOnEntry = true,
                        outputCapture = "std",
                        resolveSourceMapLocations = {
                            "${workspaceFolder}/**",
                            "!**/node_modules/**",
                        },
                        sourceMaps = true,
                        protocol = "inspector",
                    },
                }
            end
        end)
    end
}

