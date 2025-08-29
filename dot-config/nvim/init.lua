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
vim.opt.updatetime = 250
vim.opt.timeoutlen = 250
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

	-- local function underline_to_undercurl()
	-- 	local groups = vim.fn.getcompletion("", "highlight")
	-- 	for _, name in ipairs(groups) do
	-- 		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
	-- 		if ok and hl and hl.underline then
	-- 			local sp = hl.sp or hl.fg
	-- 			local new = vim.tbl_extend("force", hl, {
	-- 				underline = false,
	-- 				undercurl = true,
	-- 				sp = sp,
	-- 			})
	-- 			vim.api.nvim_set_hl(0, name, new)
	-- 		end
	-- 	end
	--
	-- 	for _, g in ipairs({
	-- 		"DiagnosticUnderlineError",
	-- 		"DiagnosticUnderlineWarn",
	-- 		"DiagnosticUnderlineInfo",
	-- 		"DiagnosticUnderlineHint",
	-- 		"SpellBad",
	-- 		"SpellCap",
	-- 		"SpellLocal",
	-- 		"SpellRare",
	-- 	}) do
	-- 		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = g, link = false })
	-- 		if ok and hl then
	-- 			vim.api.nvim_set_hl(0, g, {
	-- 				undercurl = true,
	-- 				underline = false,
	-- 				sp = hl.sp or hl.fg,
	-- 			})
	-- 		end
	-- 	end
	-- end
	--
	-- vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	-- 	group = vim.api.nvim_create_augroup("UnderlineToUndercurl", { clear = true }),
	-- 	callback = underline_to_undercurl,
	-- })

	-- [[ Adjust cursor and format options ]]
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "*" },
		callback = function()
			vim.opt.cursorline = false
			vim.opt.cursorcolumn = false
			vim.opt_local.formatoptions:remove({ "c", "r", "o" })
		end,
		group = vim.api.nvim_create_augroup("AdjustCursorLineAndCursorColumnAndFormatOptions", { clear = true }),
	})

	-- [[ Configure diagnostic behavior ]]
	local severity_map = {
		[vim.diagnostic.severity.ERROR] = "E",
		[vim.diagnostic.severity.WARN] = "W",
		[vim.diagnostic.severity.INFO] = "I",
		[vim.diagnostic.severity.HINT] = "H",
	}
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()
			local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
			local line_diagnostics = vim.diagnostic.get(bufnr, { lnum = line_num })
			if vim.tbl_isempty(line_diagnostics) then
				vim.api.nvim_echo({ { "" } }, false, {})
				return
			end
			local diagnostic_message = ""
			for i, diagnostic in ipairs(line_diagnostics) do
				local truncated_diagnostic = string.match(diagnostic.message, "([^\n]*)")
				diagnostic_message = diagnostic_message
					.. string.format("[%s] %s", severity_map[diagnostic.severity], truncated_diagnostic or "")
				if i ~= #line_diagnostics then
					diagnostic_message = diagnostic_message .. " | "
				end
			end
			vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
		end,
		group = vim.api.nvim_create_augroup("PrintDiagnostics", { clear = true }),
	})
	vim.diagnostic.config({
		underline = true,
		virtual_text = false,
		signs = false,
		virtual_lines = false,
		float = false,
	})
	local function jump_next()
		vim.diagnostic.jump({ count = 1, wrap = true, float = false })
	end
	local function jump_prev()
		vim.diagnostic.jump({ count = -1, wrap = true, float = false })
	end
	vim.keymap.set("n", "g]", jump_next, { desc = "Next diagnostic" })
	vim.keymap.set("n", "g[", jump_prev, { desc = "Prev diagnostic" })

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
		{
			"deparr/tairiki.nvim",
			config = function()
				require("tairiki").setup({
					transparent = true,
				})
				vim.cmd.colorscheme("tairiki")
			end,
		},
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
						["g["] = "lua vim.diagnostic.jump({ count = -1, wrap = true, float = false })",
						["g]"] = "lua vim.diagnostic.jump({ count = 1, wrap = true, float = false })",
					},
					on_attach = function(client, bufnr)
						-- require("lsp-setup.utils").format_on_save(client)
					end,
					capabilities = vim.lsp.protocol.make_client_capabilities(),
					servers = {
						bashls = {},
						vtsls = {},
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
					nerd_font_variant = "normal",
				},
				completion = {
					menu = {
						draw = {
							columns = {
								{ "label", "label_description", gap = 1 },
								{ "kind" },
							},
						},
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500,
					},
					ghost_text = { enabled = true },
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
			cmd = "FzfLua",
			keys = {
				{ "<leader>p", "<cmd>FzfLua files<cr>", noremap = true, silent = false, desc = "Find files" },
				{ "<leader>o", "<cmd>FzfLua buffers<cr>", noremap = true, silent = false, desc = "Find buffers" },
				{ "<leader>/", "<cmd>FzfLua live_grep_native<cr>", noremap = true, silent = false, desc = "Live grep" },
			},
			opts = {
				default = {
					file_icons = false,
				},
				fzf_colors = true,
				files = {
					file_icons = false,
					color_icons = false,
					cmd = "fd -t f",
				},
				buffers = {
					file_icons = false,
					color_icons = false,
				},
				live_grep = {
					file_icons = false,
					color_icons = false,
					cmd = "rg --hidden --column --line-number --no-heading --color=always --smart-case --",
				},
				git_files = {
					file_icons = false,
					color_icons = false,
				},
			},
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
		ui = {
			icons = {
				cmd = "",
				config = "",
				debug = "● ",
				event = "",
				favorite = "",
				ft = "",
				init = "",
				import = "",
				keys = "",
				lazy = "",
				loaded = "●",
				not_loaded = "○",
				plugin = "",
				runtime = "",
				require = "",
				source = "",
				start = "",
				task = "✔ ",
				list = {
					"●",
					"➜",
					"★",
					"‒",
				},
			},
		},
	})
end
