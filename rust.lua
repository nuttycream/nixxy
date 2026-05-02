-- override nvim conf

local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true, buffer = bufnr }

vim.keymap.set("n", "<leader>vca", function()
	vim.cmd.RustLsp("codeAction")
end, opts)

vim.keymap.set("n", "K", function()
	vim.cmd.RustLsp({ "hover", "actions" })
end, opts)

vim.keymap.set("n", "<leader>rr", function()
	vim.cmd.RustLsp("runnables")
end, opts)

vim.keymap.set("n", "<leader>rd", function()
	vim.cmd.RustLsp("debuggables")
end, opts)

vim.keymap.set("n", "<leader>re", function()
	vim.cmd.RustLsp("explainError")
end, opts)
