return {
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>tg', ':LazyGit<CR>', { silent = true, noremap = true, desc = '[T]oggle [L]azy Git' })

      vim.api.nvim_create_autocmd('TermClose', {
        callback = function(args)
          local bufnr = args.buf
          local name = vim.api.nvim_buf_get_name(bufnr)
          if name:match 'lazygit' then
            vim.cmd 'Neotree git_status refresh'
          end
        end,
      })
    end,
  },
}
