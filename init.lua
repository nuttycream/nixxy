vim.opt.nu = false
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.diagnostic.config({
	virtual_text = { current_line = true },
})
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.cmd("set guicursor=a:hor20")
	end,
})

vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

require("cyberdream").setup({
	variant = "dark",
	cache = true,
	transparent = true,
	italic_comments = true,
	extensions = {
		mini = true,
		treesitter = true,
	},
})
vim.cmd("colorscheme cyberdream")

vim.api.nvim_set_hl(0, "Pmenu", {
	bg = "#16181a",
	fg = "#ffffff",
})

require("mini.pick").setup()

vim.keymap.set("n", "<leader>pf", function()
	MiniPick.builtin.files()
end)

vim.keymap.set("n", "<leader>ps", function()
	MiniPick.builtin.grep_live()
end)

require("mini.icons").setup()
require("mini.indentscope").setup()

require("mini.pairs").setup()

require("mini.files").setup({
	mappings = {
		close = "<ESC>",
		go_in_plus = "<Enter>",
	},
	windows = {
		max_number = 1,
		preview = true,
	},
})

vim.keymap.set("n", "<leader>pv", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0))
end)

require("mini.diff").setup({
	view = {
		style = "sign",
		signs = {
			add = "+",
			change = "~",
			delete = "-",
		},
	},
})

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
	snippets = {
		gen_loader.from_lang(),
	},
})

require("mini.completion").setup({
	lsp_completion = {
		source_func = "omnifunc",
		auto_setup = true,
	},
})

vim.keymap.set("i", "<CR>", function()
	return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })

vim.keymap.set("i", "<Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })

vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.lsp.config("nixd", {
	cmd = { "nixd" },
	filetypes = { "nix" },
})

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = true,
		},
	},
})

vim.lsp.enable({
	"nixd",
	"rust_analyzer",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "alejandra" },
		rust = { "rustfmt" },
		markdown = { "prettierd" },
	},
})
