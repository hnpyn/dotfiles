---@param ft string
---@param query? string
local function have(ft, query)
	local lang = vim.treesitter.language.get_lang(ft)
	if not lang then
		return false
	end
	if not vim.tbl_contains(require("nvim-treesitter").get_installed("parsers"), lang) then
		return false
	end
	if query then
		return vim.treesitter.query.get(lang, query) ~= nil
	end
	return true
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		cmd = { "TSUpdate", "TSInstall", "TSUninstall", "TSLog" },
		keys = {
			{
				"<Leader><CR>",
				function()
					vim.treesitter.select("parent", 1)
				end,
				desc = "Init Treesitter selection",
				mode = { "n", "x" },
			},
			{
				"<CR>",
				function()
					vim.treesitter.select("parent", 1)
				end,
				desc = "Treesitter: expand to parent",
				mode = "x",
			},
			{
				"<BS>",
				function()
					vim.treesitter.select("child", 1)
				end,
				desc = "Treesitter: shrink to child",
				mode = "x",
			},
			{
				"<Tab>",
				function()
					vim.treesitter.select("extend_next", 1)
				end,
				desc = "Treesitter: expand scope",
				mode = "x",
			},
		},
		opts_extend = { "ensure_installed" },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			folds = { enable = true },
			ensure_installed = {
				"c",
				"cpp",
				"css",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"toml",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
				"yaml",
			},
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter")
			if not TS.get_installed then
				vim.notify("nvim-treesitter main branch required — run `:Lazy` to update", vim.log.levels.ERROR)
				return
			end

			TS.setup()

			local installed = TS.get_installed("parsers")
			local missing = vim.tbl_filter(function(lang)
				return not vim.tbl_contains(installed, lang)
			end, opts.ensure_installed or {})
			if #missing > 0 then
				TS.install(missing)
			end

			if opts.folds.enable ~= false then
				vim.o.foldlevel = 99
				vim.o.foldlevelstart = 99
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
				callback = function(ev)
					local ft = ev.match
					local lang = vim.treesitter.language.get_lang(ft)

					---@param feat "highlight"|"indent"|"folds"
					---@param query string
					local function enabled(feat, query)
						local f = opts[feat] or {}
						return f.enable ~= false
							and not (type(f.disable) == "table" and lang and vim.tbl_contains(f.disable, lang))
							and have(ft, query)
					end

					if enabled("highlight", "highlights") then
						vim.treesitter.start(ev.buf)
					end

					if enabled("indent", "indents") then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end

					if enabled("folds", "folds") then
						vim.wo.foldmethod = "expr"
						vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			select = {
				lookahead = true,
				keys = {
					["if"] = "@function.inner",
					["af"] = "@function.outer",
					["ic"] = "@class.inner",
					["ac"] = "@class.outer",
					["ia"] = "@parameter.inner",
					["aa"] = "@parameter.outer",
				},
			},
			move = {
				set_jumps = true,
				-- stylua: ignore start
				keys = {
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
					goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
				},
				-- stylua: ignore end
			},
		},
		config = function(_, opts)
			require("nvim-treesitter-textobjects").setup(opts)

			local function query_desc(prefix, query)
				local queries = type(query) == "table" and query or { query }
				local parts = {}
				for _, q in ipairs(queries) do
					local part = q:gsub("@", ""):gsub("%..*", "")
					part = part:sub(1, 1):upper() .. part:sub(2)
					parts[#parts + 1] = part
				end
				return prefix .. table.concat(parts, " or ")
			end

			local function move_desc(key, query)
				local desc = query_desc(key:sub(1, 1) == "[" and "Prev " or "Next ", query)
				return desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
			end

			local function attach(buf)
				local ft = vim.bo[buf].filetype
				if not have(ft, "textobjects") then
					return
				end

				for key, query in pairs(vim.tbl_get(opts, "select", "keys") or {}) do
					vim.keymap.set({ "x", "o" }, key, function()
						require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
					end, {
						buffer = buf,
						desc = query_desc("Select ", query),
						silent = true,
					})
				end

				for method, keymaps in pairs(vim.tbl_get(opts, "move", "keys") or {}) do
					for key, query in pairs(keymaps) do
						vim.keymap.set({ "n", "x", "o" }, key, function()
							if vim.wo.diff and key:find("[cC]") then
								return vim.cmd("normal! " .. key)
							end
							require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
						end, {
							buffer = buf,
							desc = move_desc(key, query),
							silent = true,
						})
					end
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_textobjects", { clear = true }),
				callback = function(ev)
					attach(ev.buf)
				end,
			})
			vim.tbl_map(attach, vim.api.nvim_list_bufs())
		end,
	},
}
