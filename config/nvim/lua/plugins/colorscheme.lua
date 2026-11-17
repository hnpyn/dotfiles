-- startup colorscheme; `<Leader>fc` only previews for the current session
local colorscheme = "claude"

-- themes load on `:colorscheme <name>`; prefer family names (no variant) so the
-- variant follows 'background', and never set vim.o.background here
local themes = {
  -- `:colorscheme catppuccin` is a builtin in nvim 0.12, use `catppuccin-nvim`
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   opts = { flavour = "auto", transparent_background = true, float = { transparent = true } },
  -- },
  { "hnpyn/claude-theme.nvim", opts = { transparent = false } },
  -- { "Mofiqul/dracula.nvim" },
  -- { "oonamo/ef-themes.nvim", opts = { transparent = false } },
  -- {
  --   "neanias/everforest-nvim",
  --   main = "everforest",
  --   version = false,
  --   opts = { background = "hard", transparent_background_level = 2 },
  -- },
  -- no family name, use a variant such as `github_dark_default`
  -- { "projekt0n/github-nvim-theme" },
  -- { "kryptamine/gruber-darker-renaissance" },
  -- { "ellisonleao/gruvbox.nvim" },
  -- {
  --   "luisiacc/gruvbox-baby",
  --   init = function()
  --     vim.g.gruvbox_baby_transparent_mode = 1
  --   end,
  -- },
  -- {
  --   "sainnhe/gruvbox-material",
  --   init = function()
  --     vim.g.gruvbox_material_background = "hard"
  --   end,
  -- },
  -- { "rebelot/kanagawa.nvim" },
  -- { "miikanissi/modus-themes.nvim" },
  -- { "EdenEast/nightfox.nvim", opts = { options = { transparent = true } } },
  -- { "navarasu/onedark.nvim", opts = { style = "dark" } },
  -- { "rose-pine/neovim", name = "rose-pine", opts = { styles = { transparency = false } } },
  -- setup() would otherwise apply its own default scheme before the requested one
  -- { "tinted-theming/tinted-nvim", opts = { apply_scheme_on_startup = false } },
  -- { "folke/tokyonight.nvim", opts = { style = "moon" } },
  -- { "Mofiqul/vscode.nvim", opts = { transparent = true } },
}

local specs = vim.tbl_map(function(spec)
  return vim.tbl_extend("keep", spec, { lazy = true })
end, themes)

-- placeholder spec (installs nothing) that applies the colorscheme at startup
table.insert(specs, {
  name = "colorscheme-loader",
  dir = vim.fn.stdpath("config"),
  lazy = false,
  priority = 10000, -- above other start plugins (snacks.nvim uses 1000)
  config = function()
    local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
    if not ok then
      vim.notify("Could not load colorscheme '" .. colorscheme .. "': " .. err, vim.log.levels.ERROR)
      vim.cmd.colorscheme("habamax")
    end
  end,
})

return specs
