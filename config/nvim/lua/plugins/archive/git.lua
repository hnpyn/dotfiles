return {
	{
		"ruifm/gitlinker.nvim",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local get_custom_type_url = function(url_data)
				local url = "http://" .. url_data.host
				if url_data.port then
					url = url .. ":" .. url_data.port .. "/"
				end
				url = url .. url_data.repo .. "/-/blob/" .. url_data.rev .. "/" .. url_data.file
				if url_data.lstart then
					url = url .. "#L" .. url_data.lstart
					if url_data.lend then
						url = url .. "-L" .. url_data.lend
					end
				end
				return url
			end

			return {
				callbacks = {
					["ip"] = function(url_data)
						url_data.port = "port"
						return get_custom_type_url(url_data)
					end,
					["domain"] = function(url_data)
						url_data.port = "port"
						return get_custom_type_url(url_data)
					end,
				},
				mappings = "<Leader>gl",
			}
		end,
		keys = {
			{
				"<Leader>gr",
				function()
					require("gitlinker").get_repo_url()
				end,
				mode = "n",
				desc = "Gitlinker: Copy repo URL",
			},
			{
				"<Leader>gR",
				function()
					require("gitlinker").get_repo_url({
						action_callback = require("gitlinker.actions").open_in_browser,
					})
				end,
				mode = "n",
				desc = "Gitlinker: Open repo URL in browser",
			},
			{
				"<Leader>gL",
				function()
					require("gitlinker").get_buf_range_url("n", {
						action_callback = require("gitlinker.actions").open_in_browser,
					})
				end,
				mode = "n",
				desc = "Gitlinker: Open buffer line URL in browser",
			},
			{
				"<Leader>gL",
				function()
					require("gitlinker").get_buf_range_url("v", {
						action_callback = require("gitlinker.actions").open_in_browser,
					})
				end,
				mode = "v",
				desc = "Gitlinker: Open visual range URL in browser",
			},
		},
	},
}
