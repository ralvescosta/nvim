-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        use_libuv_file_watcher = true,
      },
      follow_current_file = {
        enabled = true,
      },
      renderers = {
        directory = {
          { 'indent' },
          { 'icon' },
          {
            'name',
            use_git_status_colors = true,
            zindex = 10,
            highlight = 'NeoTreeDirectoryName',
            callback = function(item)
              return vim.fn.fnamemodify(item.path, ':t') -- Shows only the folder name
            end,
          },
        },
      },
    },
  },
}
