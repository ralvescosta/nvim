return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<C-y>',
            next = '<C-j>',
            prev = '<C-k>',
            dismiss = '<C-h>',
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
      }

      vim.keymap.set('n', '<leader>tc', ':Copilot toggle<CR>', { desc = '[T]oggle [C]opilot', silent = true })
    end,
  },
}
