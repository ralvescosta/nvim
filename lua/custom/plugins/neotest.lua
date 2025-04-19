return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'nvim-neotest/neotest-go',
        dependencies = {
          'leoluz/nvim-dap-go',
        },
      },
      {
        'mrcjkb/rustaceanvim',
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-go',
          require 'rustaceanvim.neotest',
        },
      }

      vim.keymap.set('n', '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = '[T]oggle [N]eotest Summary' })
      vim.keymap.set('n', '<leader>rt', "<cmd>lua require('neotest').run.run()<CR>", { desc = '[R]un [N]earest test to the cursor' })
      vim.keymap.set('n', '<leader>rf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = '[R]un entire file' })
      vim.keymap.set('n', '<leader>dt', "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<CR>", { desc = 'Debug [N]earest test' })
      vim.keymap.set('n', ']t', "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>", { desc = 'Jump to the next failed test' })
      vim.keymap.set('n', '[t', "require('neotest').jump.prev({ status = 'failed' })<CR>", { desc = 'Jump to the previous failed test' })
    end,
  },
}
