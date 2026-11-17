return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- file performance
      bigfile = { enabled = true },
      quickfile = { enabled = true },

      -- startup dashboard
      dashboard = {
        enabled = true,
        preset = {
          -- stylua: ignore start
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "n", desc = "New File", action = "<Cmd>ene | startinsert<CR>" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = "󰙅 ", key = "e", desc = "File explorer", action = "<Cmd>Oil --float<CR>" },
            { icon = " ", key = "c", desc = "Config", action = "<Cmd>e $MYVIMRC<CR>" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = "<Cmd>Lazy<CR>", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = "<Cmd>qa<CR>" },
          },
          -- stylua: ignore end
          header = [[
███╗   ███╗███████╗   ████   ██╗██╗   ██╗██╗███╗   ███╗
████╗ ████║██╔════╝   ████╗  ██║██║   ██║██║████╗ ████║
██╔████╔██║█████╗     ██╔██╗ ██║╚██╗ ██╔╝██║██╔████╔██║
██║╚██╔╝██║██╔══╝     ██║╚██╗██║ ╚████╔╝ ██║██║╚██╔╝██║
██║ ╚═╝ ██║███████╗██╗██║ ╚████║  ╚██╔╝  ██║██║ ╚═╝ ██║
╚═╝     ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝     ╚═╝]],
        },
      },

      -- kitty graphics
      image = {
        enabled = true,
        convert = {
          magick = {
            -- PNG output is lossless. `-quality 10` is zlib level 1 (faster encode,
            -- same pixels). `1600x900>` only shrinks images larger than a preview pane.
            default = { "{src}[0]", "-scale", "1600x900>", "-quality", "10", "-strip" },
          },
        },
      },

      picker = {
        enabled = true,
        ui_select = true,
        sources = {
          files = { hidden = true },
          -- list every symbol the LSP returns
          lsp_symbols = { filter = { default = true } },
          select = {
            kinds = {
              codeaction = {
                layout = {
                  preset = "vertical",
                  layout = { width = 0.5, height = 0.8 },
                },
              },
            },
          },
        },
      },

      -- editor ui
      indent = { enabled = true },
      input = { enabled = true, icon = "> " },
      scope = { enabled = true },
      scroll = { enabled = true },

      -- git url
      gitbrowse = {
        config = function(opts, defaults)
          -- table.insert(opts.remote_patterns, { "^(http://%d+%.%d+%.%d+%.%d+)(/.*)$", "%1:28088%2" })
          opts.url_patterns["%d+%.%d+%.%d+%.%d+"] = {
            branch = "/-/tree/{branch}",
            file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
            permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
            commit = "/-/commit/{commit}",
          }
        end,
      },
    },
    -- stylua: ignore start
    keys = {
      -- buffer / file
      { "<Leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<Leader>br", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<Leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },

      -- finder
      { "<Leader>/", function() Snacks.picker.grep() end, desc = "Live Grep" },
      { "<Leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
      { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<Leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<Leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
      { "<Leader>fR", function() Snacks.picker.resume() end, desc = "Resume Find" },
      { "<Leader>fc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      { "<Leader>gc", function() Snacks.picker.git_log() end, desc = "Git: Commits" },
      { "<Leader>gs", function() Snacks.picker.git_status() end, desc = "Git: Status" },

      -- git
      { "<Leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
      {
        "<Leader>gl",
        function()
          Snacks.gitbrowse({
            open = function(url)
              url = url:gsub("^https://http://", "http://")
              vim.fn.setreg("+", url)
              vim.notify("Copied [origin](" .. url .. ")")
            end,
            notify = false,
          })
        end,
        desc = "GitBrowse: Copy URL",
        mode = { "n", "x" },
      },
    },
    -- stylua: ignore end
  },
}
