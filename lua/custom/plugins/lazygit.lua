return {
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>tg', ':LazyGit<CR>', { silent = true, noremap = true, desc = '[T]oggle [L]azy Git' })
    end,
  },
}
