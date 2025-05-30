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
          debounce = 50,
          keymap = {
            accept = '<Tab>',
            next = '<C-j>',
            prev = '<C-k>',
            dismiss = '<C-h>',
            refresh = '<C-l>',
          },
        },
        filetypes = {
          ['*'] = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          json = false,
        },
      }

      vim.keymap.set('n', '<leader>tc', ':Copilot toggle<CR>', { desc = '[T]oggle [C]opilot', silent = true })
    end,
  },
}
