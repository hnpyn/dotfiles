local util = require("util")

-- copy messages
vim.api.nvim_create_user_command("CopyMessages", function()
	vim.cmd("redir @+ | silent messages | redir END")
	print("Copied messages")
end, { desc = "Copy messages to clipboard" })

-- copy path
vim.api.nvim_create_user_command("GetFilePath", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
	print("Copied path: " .. vim.fn.expand("%:p"))
end, { desc = "Copy file path to clipboard" })

-- get diagnostic
vim.api.nvim_create_user_command("GetDiagnostics", function()
	local text = util.get_diagnostic_text()
	if text then
		vim.fn.setreg("+", text)
		print("Copied diagnostics: " .. text)
	else
		print("No diagnostics on current line")
	end
end, { desc = "Copy diagnostics to clipboard" })
