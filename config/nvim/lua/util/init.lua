local LazyUtil = require("lazy.core.util")

local M = {}

M.root_patterns = { ".git", "lua" }

---Returns the color set by the current colorscheme for the `attr` attribute of
---the `hlgroup_name` highlight group in hexadecimal format.
---@param hlgroup string
---@param attr '"fg"' | '"bg"'
---@return string
function M.get_hex(hlgroup, attr)
	local id = vim.api.nvim_get_hl(0, { name = hlgroup })
	local color = (attr == "fg") and id.fg or id.bg
	return color and string.format("#%06x", color) or "NONE"
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

---@param plugin string
function M.has(plugin)
	return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

function M.has_words_before()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

---@class HighlightDef
---@field fg? number
---@field foreground? number
---@return {fg:string}|nil
function M.fg(name)
	---@type HighlightDef
	local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
		or vim.api.nvim_get_hl_by_name(name, true)
	local fg = hl and hl.fg or hl.foreground
	return fg and { fg = string.format("#%06x", fg) }
end

---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			fn()
		end,
	})
end

---@param name string
function M.opts(name)
	local plugin = require("lazy.core.config").plugins[name]
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
	---@type string?
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and vim.loop.fs_realpath(path) or nil
	---@type string[]
	local roots = {}
	if path then
		for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace
					and vim.tbl_map(function(ws)
						return vim.uri_to_fname(ws.uri)
					end, workspace)
				or client.config.root_dir and { client.config.root_dir }
				or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	table.sort(roots, function(a, b)
		return #a > #b
	end)
	---@type string?
	local root = roots[1]
	if not root then
		path = path and vim.fs.dirname(path) or vim.loop.cwd()
		---@type string?
		root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	---@cast root string
	return root
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
	local Config = require("lazy.core.config")
	if Config.plugins[name] and Config.plugins[name]._.loaded then
		vim.schedule(function()
			fn(name)
		end)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

function M.is_remote()
	return os.getenv("SSH_CLIENT") or os.getenv("SSH_TTY") or os.getenv("SSH_CONNECTION")
end

function M.is_tmux()
	return os.getenv("TMUX")
end

function M.get_diagnostic_text()
	local line = vim.fn.line(".") - 1
	local diagnostics = vim.diagnostic.get(0, { lnum = line })
	if #diagnostics > 0 then
		return table.concat(vim.tbl_map(function(d)
			return d.message
		end, diagnostics))
	end
end

---@return string (git repo with out .git)
function M.get_git_repo()
	local repo = vim.fn.systemlist("git remote get-url origin")[1] or ""
	repo = repo:gsub("%.git$", "")
	return repo
end

---@return {branch:string, file:string, line_start:number, line_end:number, line_count:number}
function M.get_git_fields()
	local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
	local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

	local line_start, line_end
	if vim.fn.mode():find("[vV]") then
		line_start = vim.fn.line("v")
		line_end = vim.fn.line(".")
		if line_start > line_end then
			line_start, line_end = line_end, line_start
		end
	else
		line_start = vim.fn.line(".")
		line_end = line_start
	end

	return {
		branch = branch,
		file = file,
		line_start = line_start,
		line_end = line_end,
		line_count = line_end - line_start + 1,
	}
end

return M
