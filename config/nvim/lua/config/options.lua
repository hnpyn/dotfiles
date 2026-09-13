local set = vim.o

-- basic
set.autoindent = true
set.autoread = true
set.cursorline = true
set.expandtab = true
set.number = true
set.relativenumber = true
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
set.termguicolors = true

-- clipboard
-- providers from `:h clipboard`; ignore `$TMUX` inside herdr
local function has_clipboard_provider()
	if os.getenv("TMUX") and not (os.getenv("HERDR_PANE_ID") or os.getenv("HERDR_ENV")) then
		return true
	end
	if vim.fn.executable("pbcopy") == 1 then
		return true
	end
	if os.getenv("WAYLAND_DISPLAY") and vim.fn.executable("wl-copy") == 1 then
		return true
	end
	if os.getenv("DISPLAY") and (vim.fn.executable("xclip") == 1 or vim.fn.executable("xsel") == 1) then
		return true
	end
	return false
end

set.clipboard = "unnamedplus"
if not has_clipboard_provider() then
	local osc52 = require("vim.ui.clipboard.osc52")
	local function paste()
		return {
			vim.fn.split(vim.fn.getreg(""), "\n"),
			vim.fn.getregtype(""),
		}
	end
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = osc52.copy("+"),
			["*"] = osc52.copy("*"),
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
end
