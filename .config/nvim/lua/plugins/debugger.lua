vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    vim.keymap.set("n", "<leader>cdd", function()
      require("dapui").toggle({})
    end, { desc = "Toggle debugger", nowait = true, remap = false })

    vim.keymap.set("n", "<leader>cdq", function()
      require("dap").terminate()
      require("dapui").close()
      require("nvim-dap-virtual-text").toggle()
    end, { desc = "Quit debugger", nowait = true, remap = false })

    vim.keymap.set("n", "<leader>cdt", function()
      require("dap").toggle_breakpoint()
    end, { desc = "Toggle breakpoint", nowait = true, remap = false })

    vim.keymap.set("n", "<leader>cdn", function()
      require("dap").continue()
    end, { desc = "Next breakpoint", nowait = true, remap = false })

    vim.keymap.set("n", "<leader>cdN", function()
      require("dap").reverse_continue()
    end, { desc = "Previous breakpoint", nowait = true, remap = false })

    vim.keymap.set("n", "<leader>cdgd", function()
      require("dap").step_into()
    end, { desc = "Step into breakpoint", nowait = true, remap = false })

    vim.keymap.set("n", "<leader>cdo", function()
      require("dap").step_out()
    end, { desc = "Step out breakpoint", nowait = true, remap = false })
  end,
})

return {}
