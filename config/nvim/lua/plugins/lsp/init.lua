return {
	{
		"mason-org/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
			"MasonUpdate",
		},
		opts = {
			ensure_installed = {
				"stylua",
				"lua-language-server",
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
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", opts = {} },
		},
		opts = {
			servers = {
				pyright = {
					settings = {
						pyright = {
							-- Using Ruff's import organizer
							disableOrganizeImports = true,
						},
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "openFilesOnly",
								typeCheckingMode = "off",
								useLibraryCodeForTypes = true,
								ignore = { "*" },
							},
						},
					},
				},
				ruff = {
					init_options = {
						settings = {
							lineLength = 120,
							lint = {
								enabled = true,
								preview = true,
								select = { "E", "F", "W" },
								ignore = { "E501", "W291", "W292" },
							},
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							single_file_support = true,
							diagnostics = {
								globals = { "vim", "hs" },
							},
							workspace = {
								checkThirdParty = true,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				clangd = {},
			},
			setup = {},
		},
		config = function(_, opts)
			require("plugins.lsp.keymaps")

			local servers = opts.servers
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local has_blink, blink = pcall(require, "blink.cmp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				has_blink and blink.get_lsp_capabilities() or {},
				opts.capabilities or {}
			)

			for server, cfg in pairs(servers) do
				if cfg then
					cfg = cfg == true and {} or cfg
					cfg = vim.tbl_deep_extend("force", {
						capabilities = vim.deepcopy(capabilities),
					}, cfg or {})
					if cfg.enabled ~= false then
						vim.lsp.config(server, cfg)
						vim.lsp.enable(server)
					end
				end
			end
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cF",
				function()
					require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			format_on_save = function(bufnr)
				local ignore_filetypes = { "python" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end

				return { timeout_ms = 3000, lsp_format = "fallback" }
			end,
			formatters = {
				injected = { options = { ignore_errors = true } },
			},
		},
	},
}
