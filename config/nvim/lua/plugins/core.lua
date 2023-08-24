return {
  { "nvim-lua/plenary.nvim" },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({})

      local function opts(desc)
        return { desc = "" .. desc, noremap = true, silent = true }
      end

      -- lazygit
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "curved",
          width = 160,
          height = 40,
        },
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      -- keymaps
      vim.keymap.set("n", "<C-t>", "<Cmd>ToggleTerm size=40 direction=float<CR>", opts(""))
      vim.keymap.set("t", "<C-t>", "<C-\\><C-n><Cmd>q<CR>", opts(""))
      vim.keymap.set("n", "<Leader>lg", "<Cmd>lua _lazygit_toggle()<CR>", opts("Toggleterm: lazygit"))
      vim.cmd.cnoreabbrev("lg lua _lazygit_toggle()")
    end,
  },
  {
    "chrishrb/gx.nvim",
    event = { "BufEnter" },
    config = true, -- default settings
  },
  {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end
      require("ufo").setup({
        fold_virt_text_handler = handler,
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end
      })
    end,
  },
}
