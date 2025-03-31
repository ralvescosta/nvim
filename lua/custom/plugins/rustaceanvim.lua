return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    pft = 'rust',
    config = function()
      local mason_registry = require 'mason-registry'
      local codelldb = mason_registry.get_package 'codelldb'
      local extension_path = codelldb:get_install_path() .. '/extension/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
      local cfg = require 'rustaceanvim.config'
      local dap = require 'dap'

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        tools = {
          float_win_config = {
            border = 'rounded',
          },
        },
      }

      local function get_program_name()
        if not vim.g._last_rust_program or vim.g._last_rust_program == '' then
          vim.g._last_rust_program = vim.fn.input('Enter binary name: ', '')
        end
        return vim.g._last_rust_program
      end

      dap.configurations.rust = {
        {
          type = 'codelldb',
          request = 'launch',
          name = 'dynamic launcher',

          program = function()
            local name = get_program_name()

            vim.notify('Compiling ' .. name .. '...', vim.log.levels.INFO)

            local result = vim.fn.system {
              'cargo',
              'build',
              '--bin',
              name,
              '--package',
              name,
            }

            if vim.v.shell_error ~= 0 then
              vim.notify('Cargo build failed:\n' .. result, vim.log.levels.ERROR)
              return ''
            end

            vim.notify('Binary ' .. name .. ' compiled successfully', vim.log.levels.INFO)
            return string.format('${workspaceFolder}/target/debug/%s', name)
          end,

          cargo = {
            args = function()
              vim.notify('cargo args', vim.log.levels.INFO)
              local pn = get_program_name()
              return { 'build', string.format('--bin=%s', pn), string.format('--package=%s', pn) }
            end,
            filter = {
              name = function()
                vim.notify('cargo filters', vim.log.levels.INFO)
                return get_program_name()
              end,
              kind = 'bin',
            },
          },

          env = {
            app_name = function()
              vim.notify('envs', vim.log.levels.INFO)
              return get_program_name()
            end,
            RUST_ENV = 'local',
            RUST_BACKTRACE = 'full',
          },

          cwd = '${workspaceFolder}',
        },
      }
      --
    end,
  },
}
