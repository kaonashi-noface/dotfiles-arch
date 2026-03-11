-- Typography Keybinds:
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Editor Keybinds:
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Debuger UI Keybinds:
local dapui = require("dapui")
vim.keymap.set("n", "<space>dui", dapui.toggle)
local dap = require("dap")
vim.keymap.set("n", "<space>b",  dap.toggle_breakpoint)

-- Debugging Keybinds:
vim.keymap.set("n", "<space>d<Right>",  dap.step_over)
vim.keymap.set("n", "<space>d<Down>",  dap.step_into)
vim.keymap.set("n", "<space>d<Up>",  dap.step_out)
vim.keymap.set("n", "<space>d<Left>",  dap.continue)
vim.keymap.set("n", "<space>dr",  dap.restart)
vim.keymap.set("n", "<space>dq",  dap.terminate)
vim.keymap.set("n", "<space>d<BS>",  dap.clear_breakpoints)

-- LSP Keybinds:
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>')
