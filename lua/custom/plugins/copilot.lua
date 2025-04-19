return {
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_enabled = false

      vim.api.nvim_create_user_command('CopilotToggle', function()
        if vim.g.copilot_enabled == 1 then
          vim.g.copilot_enabled = 0
          print 'Copilot: OFF'
        else
          vim.g.copilot_enabled = 1
          print 'Copilot: ON'
        end
      end, {})

      vim.keymap.set('n', '<leader>tc', ':CopilotToggle<CR>', { desc = '[T]oggle [C]opilot', silent = true })
    end,
  },
}
