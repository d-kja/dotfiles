local function clear_backgrounds()
  vim.cmd.hi("Comment gui=NONE")
  vim.cmd.hi("Normal guibg=NONE")
  vim.cmd.hi("Normal ctermbg=NONE")
  vim.cmd.hi("NonText guibg=NONE")
  vim.cmd.hi("NonText ctermbg=NONE")
  vim.cmd.hi("netrwPlain guibg=NONE")
  vim.cmd.hi("netrwDir guibg=NONE")
  vim.cmd.hi("@tag guibg=NONE")
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user_transparent", { clear = true }),
  callback = clear_backgrounds,
})

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      transparent = true,
      styles = {
        comments = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      local transparent = require("transparent")

      transparent.setup({
        groups = {
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLine",
          "CursorLineNr",
          "StatusLine",
          "StatusLineNC",
          "EndOfBuffer",
        },
        extra_groups = {
          "NormalFloat",
          "NvimTreeNormal",
        },
        exclude_groups = {},
      })

      transparent.clear_prefix("NeoTree")
      clear_backgrounds()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },
}
