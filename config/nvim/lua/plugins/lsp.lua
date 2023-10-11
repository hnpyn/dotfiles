return {
	{ "folke/neodev.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
			"MasonUpdate",
			"MasonUpdateAll",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"black",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_uninstalled = "✗",
					package_pending = "⟳",
				},
			},
		},
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black.with({
						extra_args = { "--line-length", "120" },
					}),
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.markdownlint,
					-- null_ls.builtins.formatting.yamlfmt,
					null_ls.builtins.formatting.shfmt,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		enabled = false,
		config = function()
			require("aerial").setup({
				attach_mode = "global",
				backends = { "lsp", "treesitter", "markdown", "man" },
				disable_max_lines = 1000,
				disable_max_size = 102400,
				layout = { min_width = 28 },
				show_guides = true,
				filter_kind = false,
				guides = {
					mid_item = "├ ",
					last_item = "└ ",
					nested_top = "│ ",
					whitespace = "  ",
				},
				keymaps = {
					["[y"] = "actions.prev",
					["]y"] = "actions.next",
					["[Y"] = "actions.prev_up",
					["]Y"] = "actions.next_up",
					["{"] = false,
					["}"] = false,
					["[["] = false,
					["]]"] = false,
				},
			})
			vim.keymap.set("n", "<Leader>a", "<Cmd>AerialToggle!<CR>")
		end,
	},
	{
		"SmiteshP/nvim-navic",
		enabled = false,
		lazy = true,
		init = function()
			-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
			vim.g.navic_silence = true
			require("utils").on_attach(function(client, buffer)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, buffer)
				end
			end)
		end,
		opts = function()
			return {
				separator = " ",
				highlight = true,
				depth_limit = 5,
				icons = require("config.ui").icons.kinds,
			}
		end,
	},
	{
		"SmiteshP/nvim-navbuddy",
		enabled = false,
		cmd = "Navbuddy",
		init = function()
			vim.cmd.cnoreabbrev("na Navbuddy")
		end,
		opts = { lsp = { auto_attach = true } },
	},
}
