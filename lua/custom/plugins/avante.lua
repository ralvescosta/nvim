return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    opts = {
      providers = {
        copilot = {
          model = 'claude-3.7-sonnet',
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 8192,
          },
        },
      },
      cursor_applying_provider = 'copilot',
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      -- "stevearc/dressing.nvim",
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
}
