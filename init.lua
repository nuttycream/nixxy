vim.opt.nu = true
vim.opt.relativenumber = true
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
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")

vim.keymap.set("n", "<leader>pf", function()
	require("fzf-lua").files()
end)

vim.keymap.set("n", "<leader>ps", function()
	require("fzf-lua").live_grep()
end)

require("cyberdream").setup({
	variant = "dark",
	transparent = true,
	italic_comments = true,
	extensions = {
		fzflua = true,
		treesitter = true,
	},
})
vim.cmd("colorscheme cyberdream")

require("oil").setup({
	skip_confirm_for_simple_edits = true,
	columns = { "icon", "size" },
	view_options = {
		show_hidden = true,
	},
})

require("fzf-lua").setup({
	winopts = {
		border = "none",
	},
})

require("gitsigns").setup()

require("blink.cmp").setup({
	signature = { enabled = true },
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
	},
})

vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
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

require("mini.icons").setup()
require("mini.indentscope").setup()
