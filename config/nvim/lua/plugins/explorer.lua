return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>fe", "<Cmd>Oil<CR>", desc = "File Explorer" },
    },
    opts = {
      default_file_explorer = true,
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
      },
      view_options = {
        show_hidden = true,
      },
      -- for oil-git-status
      win_options = {
        signcolumn = "yes:2",
      },
    },
  },
  {
    "refractalize/oil-git-status.nvim",
    enabled = true,
    lazy = true,
    dependencies = "stevearc/oil.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {
        "<leader>tt",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("utils").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>te",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = function()
      local icons = require("config.ui").icons
      return {
        popup_border_style = "rounded",
        use_popups_for_input = true,
        close_if_last_window = true,
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = {
            ["<space>"] = "none",
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = nil, -- true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = icons.file.FoldClosed,
            expander_expanded = icons.file.FoldOpen,
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_empty = icons.file.FolderEmpty,
            folder_empty_open = icons.file.FolderEmpty,
            default = icons.file.DefaultFile,
          },
          modified = { symbol = icons.file.FileModified },
          git_status = {
            symbols = {
              added = icons.git.added,
              deleted = icons.git.removed,
              modified = icons.git.modified,
              renamed = icons.git.renamed,
              untracked = icons.git.untracked,
              ignored = icons.git.ignored,
              unstaged = icons.git.unstaged,
              staged = icons.git.staged,
              conflict = icons.git.conflict,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}
