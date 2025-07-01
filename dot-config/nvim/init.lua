-- [[ IDK ]]
vim.loader.enable()

-- [[ Configure Neovim ]]
vim.g.mapleader = " "
vim.g.localleader = " "
vim.opt.guicursor = ""
vim.opt.shortmess = "atToOIc"
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.termguicolors = true
vim.opt.linespace = 0
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.showtabline = 0
vim.opt.hidden = false
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.matchtime = 0
vim.opt.wrap = false
vim.opt.listchars = { tab = "  ", eol = " ", lead = " ", trail = "·", nbsp = ".", extends = "#" }
vim.opt.list = true
vim.opt.scrolloff = 20
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.signcolumn = "no"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.tabstop = 2
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildignorecase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.joinspaces = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeout = true
vim.opt.updatetime = 200
vim.opt.timeoutlen = 200
vim.opt.ttyfast = true
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 1000
vim.opt.laststatus = 3

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case" -- high performance grep
vim.g.markdown_recommended_style = 0 -- allow 2 space on markdown file

-- [[ Navigation Keymap ]]
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, ";", ":", { noremap = true, silent = false })
vim.keymap.set("n", "<cr>", ":nohls<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<c-h>", "<c-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { noremap = true, silent = true })

if not vim.g.vscode then
	-- [[ Color ]]
	vim.opt.background = "dark"
	local highlights = {
		Normal = { bg = nil },
		FloatBorder = { bg = nil },
	}
	for k, v in pairs(highlights) do
		vim.api.nvim_set_hl(0, k, v)
	end

	-- [[ Automatic commands ]]
	local generalSettingsGroup = vim.api.nvim_create_augroup("General settings", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "*" },
		callback = function()
			vim.opt.cursorline = false
			vim.opt.cursorcolumn = false
			vim.opt_local.formatoptions:remove({ "c", "r", "o" })
		end,
		group = generalSettingsGroup,
	})

	-- [[ Configure Plugins ]]
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.uv.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	require("lazy").setup({
		-- {
		-- 	"deparr/tairiki.nvim",
		-- 	branch = "v2",
		-- 	lazy = false,
		-- 	priority = 1000,
		-- 	config = function()
		-- 		local theme = require("tairiki")
		-- 		theme.setup({
		-- 			style = "dark",
		-- 			transparent = true,
		-- 		})
		-- 		theme.load()
		-- 	end,
		-- },
		{
			"numtostr/comment.nvim",
			config = true,
		},
		{
			"stevearc/oil.nvim",
			version = "*",
			config = true,
		},
		{
			"mikesmithgh/borderline.nvim",
			enabled = true,
			lazy = true,
			event = "VeryLazy",
			config = function()
				require("borderline").setup({
					border = {
						[1] = "",
						[2] = "",
						[3] = "",
						[4] = "",
						[5] = "",
						[6] = "",
						[7] = "",
						[8] = "",
					},
				})
			end,
		},
		{
			"junnplus/lsp-setup.nvim",
			dependencies = {
				"neovim/nvim-lspconfig",
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
			},
			config = function()
				require("mason").setup()
				require("lsp-setup").setup({
					default_mappings = false,
					mappings = {
						gd = "lua vim.lsp.buf.definition()",
						gt = "lua vim.lsp.buf.type_definition()",
						gi = "lua vim.lsp.buf.implementation()",
						gh = "lua vim.lsp.buf.references()",
						gk = "lua vim.lsp.buf.hover()",
						gr = "lua vim.lsp.buf.rename()",
						ga = "lua vim.lsp.buf.code_action()",
						ge = "lua vim.diagnostic.open_float()",
						["g["] = "lua vim.diagnostic.goto_prev()",
						["g]"] = "lua vim.diagnostic.goto_next()",
					},
					on_attach = function(client, bufnr)
						-- require("lsp-setup.utils").format_on_save(client)
					end,
					capabilities = vim.lsp.protocol.make_client_capabilities(),
					servers = {
						bashls = {},
						vtsls = {},
						quick_lint_js = {},
						tailwindcss = {},
						emmet_language_server = {},
						terraformls = {},
						marksman = {},
						gopls = {
							settings = {
								gopls = {
									analyses = {
										unusedparams = true,
										unreachable = true,
									},
									staticcheck = true,
									gofumpt = true,
								},
							},
						},
						clangd = {},
						pyright = {},
						ruff = {},
						rust_analyzer = {
							settings = {
								["rust-analyzer"] = {
									imports = {
										granularity = {
											group = "module",
										},
										prefix = "self",
									},
									cargo = {
										loadOutDirsFromCheck = true,
										buildScripts = {
											enable = true,
										},
									},
									procMacro = {
										enable = true,
									},
									checkOnSave = true,
								},
							},
						},
						lua_ls = {
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim", "kong", "ngx" },
									},
								},
							},
						},
						zls = {},
					},
					inlay_hints = {
						enabled = false,
						highlight = "Comment",
					},
				})
			end,
		},
		{
			"olexsmir/gopher.nvim",
			ft = "go",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"mfussenegger/nvim-dap",
			},
			config = true,
		},
		{
			"stevearc/conform.nvim",
			event = "BufWritePre",
			cmd = "ConformInfo",
			version = "*",
			opts = {
				formatters_by_ft = {
					bash = { "shfmt" },
					go = { "goimports", "gofumpt" },
					javascript = { "biome" },
					javascriptreact = { "biome", "rustywind" },
					json = { "prettier" },
					lua = { "stylua" },
					python = { "ruff_fix", "ruff_format" },
					ruby = { "rubyfmt" },
					rust = { "rustfmt" },
					typescript = { "biome" },
					typescriptreact = { "biome", "rustywind" },
					yaml = { "prettier" },
					html = { "prettier" },
					markdown = { "prettier" },
					sql = { "sleek" },
					["*"] = { "trim_whitespace" },
				},
				format_on_save = {
					timeout_ms = 1000,
					quiet = true,
					lsp_format = "fallback",
				},
				default_format_opts = {
					timeout_ms = 1000,
					quiet = true,
					lsp_format = "fallback",
				},
			},
		},
		{
			"aserowy/tmux.nvim",
			opts = {
				copy_sync = {
					enable = false,
				},
			},
		},

		{
			"karb94/neoscroll.nvim",
			opts = {},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			build = ":TSUpdate",
			config = function()
				vim.defer_fn(function()
					require("nvim-treesitter.configs").setup({
						ensure_installed = {
							"bash",
							"c",
							"c_sharp",
							"cpp",
							"css",
							"go",
							"html",
							"javascript",
							"json",
							"jsonc",
							"lua",
							"markdown",
							"python",
							"rust",
							"sql",
							"templ",
							"toml",
							"tsx",
							"typescript",
							"vimdoc",
							"yaml",
						},
						auto_install = true,
						highlight = {
							enable = true,
							additional_vim_regex_highlighting = false,
						},
						indent = { enable = true },
						textobjects = {
							select = {
								enable = true,
								lookahead = true,
								keymaps = {
									["aa"] = "@parameter.outer",
									["ia"] = "@parameter.inner",
									["ab"] = "@block.outer",
									["ib"] = "@block.inner",
									["ac"] = "@class.outer",
									["ic"] = "@class.inner",
									["af"] = "@function.outer",
									["if"] = "@function.inner",
									["al"] = "@loop.outer",
									["il"] = "@loop.inner",
									["am"] = "@call.outer",
									["im"] = "@call.inner",
									["as"] = "@statement.outer",
									["is"] = "@statement.inner",
								},
							},
						},
					})
				end, 0)
			end,
		},
		{
			"saghen/blink.cmp",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "*",
			opts = {
				keymap = { preset = "enter" },
				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				cmdline = {
					enabled = false,
				},
				signature = { enabled = true },
			},
			opts_extend = { "sources.default" },
		},
		{
			"ibhagwan/fzf-lua",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			cmd = "FzfLua",
			keys = {
				{ "<leader>p", "<cmd>FzfLua files<cr>", noremap = true, silent = false, desc = "Find files" },
				{ "<leader>o", "<cmd>FzfLua buffers<cr>", noremap = true, silent = false, desc = "Find buffers" },
				{ "<leader>/", "<cmd>FzfLua live_grep_native<cr>", noremap = true, silent = false, desc = "Live grep" },
			},
			opts = { "skim" },
		},
		{
			"vim-test/vim-test",
			keys = {
				{ "<leader>tn", "<cmd>TestNearest<cr>", noremap = true, silent = false, desc = "Run test nearest" },
				{ "<leader>tf", "<cmd>TestFile<cr>", noremap = true, silent = false, desc = "Run test file" },
				{ "<leader>ta", "<cmd>TestSuite<cr>", noremap = true, silent = false, desc = "Run test suite" },
				{ "<leader>tl", "<cmd>TestLast<cr>", noremap = true, silent = false, desc = "Run test last" },
			},
		},
	}, {
		rocks = {
			hererocks = false,
			enabled = false,
		},
		install = {
			missing = true,
			colorscheme = { "default" },
		},
		checker = { enabled = false },
	})
end
