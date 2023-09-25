return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    version = "*",
    keys = {
      {
        "<Leader>tt",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
        desc = "nvim-tree toggle",
      },
      {
        "<Leader>tf",
        function()
          require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
        end,
        desc = "nvim-tree find file",
      },
    },
    config = function()
      local map = vim.keymap.set

      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        map("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        map("n", "?", api.tree.toggle_help, opts("Help"))
      end

      -- pass to setup along with your other options
      require("nvim-tree").setup({
        -- disables netrw completely
        disable_netrw = false,
        on_attach = my_on_attach,
        sort_by = "case_sensitive",
        view = {
          width = 40,
          relativenumber = true,
        },
        renderer = {
          group_empty = true,
          full_name = true,
          icons = {
            show = {
              folder_arrow = true,
            },
            glyphs = {
              folder = {
                arrow_closed = " ",
                arrow_open = " ",
              },
            },
          },
        },
        filters = {
          custom = {
            ".git/", -- 不显示 .git 目录内容
          },
          exclude = {
            ".gitignore", -- 显示 .gitignore
          },
          dotfiles = true,
        },
        git = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
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
      -- { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      -- { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
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
