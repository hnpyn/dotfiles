local M = {}

M.lazy_version = ">=9.1.0"

M.icons = {
	dap = {
		Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
		Breakpoint = " ",
		BreakpointCondition = " ",
		BreakpointRejected = { " ", "DiagnosticError" },
		LogPoint = ".>",
	},
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
	git = {
		git = "󰊢",
		added = " ",
		modified = " ",
		removed = " ",
		branch = "",
		conflict = "",
		ignored = "◌",
		renamed = "➜",
		gitsign = "▎",
		staged = "✓",
		unstaged = "✗",
		untracked = "★",
	},
	kinds = {
		Array = " ",
		Boolean = " ",
		Class = " ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Copilot = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = " ",
		Interface = " ",
		Key = " ",
		Keyword = " ",
		Method = " ",
		Module = " ",
		Namespace = " ",
		Null = " ",
		Number = " ",
		Object = " ",
		Operator = " ",
		Package = " ",
		Property = " ",
		Reference = " ",
		Snippet = " ",
		String = " ",
		Struct = " ",
		Text = " ",
		TypeParameter = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
	},
	file = {
		DefaultFile = "󰈙",
		FileNew = "",
		FileModified = "",
		FileReadOnly = "",
		FoldClosed = "",
		FoldOpened = "",
		FoldSeparator = " ",
		FolderClosed = "",
		FolderEmpty = "",
		FolderOpen = "",
	},
}

return M