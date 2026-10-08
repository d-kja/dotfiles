-- Applied after LazyVim's own keymaps, so these win over defaults like Snacks explorer.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    vim.keymap.set({ "n", "v" }, "<leader>cfa", function()
      LazyVim.format({ force = true })
    end, { desc = "Format" })

    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
    vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

    vim.keymap.set("t", "<leader>tt", "<cmd>close<cr>", { desc = "Hide Terminal" })
    vim.keymap.set("n", "<leader>tq", function()
      Snacks.terminal(nil, { cwd = LazyVim.root() })
    end, { desc = "Terminal (Root Dir)" })

    -- Go back to explorer
    vim.keymap.set("n", "-", function()
      vim.api.nvim_command("Ex")
    end)

    -- Moves to the left/right
    vim.keymap.set("n", "<leader>c<Left>", "0", { desc = "Go to the start of the line" })
    vim.keymap.set("n", "<leader>C<Left>", "0", { desc = "Go to the start of the line" })
    vim.keymap.set("n", "<leader>c<Right>", "$", { desc = "Go to the end of the line" })
    vim.keymap.set("n", "<leader>C<Right>", "$", { desc = "Go to the end of the line" })

    vim.keymap.set("n", "<leader><tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })
    vim.keymap.set("n", "<leader><tab><Left>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
    vim.keymap.set("n", "<leader><tab><Right>", "<cmd>tabnext<cr>", { desc = "Next Tab" })

    -- highlights under cursor
    vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
    vim.keymap.set("n", "<leader>uI", function()
      vim.treesitter.inspect_tree()
      vim.api.nvim_input("I")
    end, { desc = "Inspect Tree" })

    vim.keymap.set("n", "<leader>lr", function()
      require("persistence").load()
    end, { desc = "Restore session" })
    vim.keymap.set("n", "<leader>ls", function()
      require("persistence").select()
    end, { desc = "Select session" })

    vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

    -- skill-issue remaps
    vim.keymap.set("n", "I", "i")
    vim.keymap.set("n", "U", "u")
  end,
})

return {}
