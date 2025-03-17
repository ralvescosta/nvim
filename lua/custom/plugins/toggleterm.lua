return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {--[[ things you want to change go here]]
    },
    config = function()
      require('toggleterm').setup {}

      vim.keymap.set('n', '<A-i>', ':ToggleTerm direction=float<CR>', { desc = '[T]oggleTerm float' })
      vim.keymap.set('t', '<A-i>', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true, silent = true })
    end,
  },
}
