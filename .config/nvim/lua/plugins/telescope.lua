return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    return {
      { "<leader>q", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>s", "<cmd>Telescope oldfiles<cr>", desc = "Search old files" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep files" },
    }
  end,
}
