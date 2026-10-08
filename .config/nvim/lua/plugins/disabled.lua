return {
  { "mrcjkb/rustaceanvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/snacks.nvim",
    recommended = false,
    opts = {
      animate = { enabled = false },
      scroll = { enabled = false },
      explorer = { enabled = false },
      dashboard = { enabled = false },
      git = { enabled = false },
      gh = { enabled = false },
      gitbrowse = { enabled = false },
      lazygit = { enabled = false },
      -- statuscolumn = { enabled = false },
      -- picker = { enabled = false },
      -- image = { enabled = false },
      -- indent = { enabled = false },
      -- input = { enabled = false },
      -- layout = { enabled = false },
      -- bigfile = { enabled = true },
      -- bufdelete = { enabled = false },
      -- dim = { enabled = false },
      -- profiler = { enabled = false },
      -- scope = { enabled = false },
      -- terminal = { enabled = false },
      -- win = { enabled = false },
    },
    -- Drops Snacks spec keymaps (including explorer on <leader>e / <leader>E).
    -- Picker, terminal, and the other modules above stay enabled.
    keys = false,
  },
  {
    "mfussenegger/nvim-lint",
    enabled = false,
  },
}
