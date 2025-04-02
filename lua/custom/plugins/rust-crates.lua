return {
  {
    'saecki/crates.nvim',
    ft = { 'toml' },
    config = function()
      require('crates').setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require('cmp').setup.buffer {
        sources = { { name = 'crates' } },
      }

      -- vim.keymap.set('n', '<leader>cu', '<CMD>Crates update_crate<CR>', { desc = '[C]reate update' })
    end,
  },
}
