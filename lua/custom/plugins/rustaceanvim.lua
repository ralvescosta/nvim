return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    pft = 'rust',
    config = function()
      local mason_registry = require 'mason-registry'

      local mason_base = vim.fn.expand '$MASON'
      if mason_base == '' then
        mason_base = vim.fn.stdpath 'data' .. '/mason'
      end

      local codelldb_install = mason_base .. '/packages/codelldb'
      local extension_path = codelldb_install .. '/extension/'
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

      -- Reset binary name after session ends
      dap.listeners.after.event_terminated['reset-rust-program'] = function()
        vim.g._last_rust_program = nil
        vim.notify('Clearing previous Rust binary name', vim.log.levels.DEBUG)
      end

      dap.listeners.after.event_exited['reset-rust-program'] = function()
        vim.g._last_rust_program = nil
        vim.notify('Clearing previous Rust binary name', vim.log.levels.DEBUG)
      end

      dap.listeners.after.disconnect['reset-rust-program'] = function()
        vim.g._last_rust_program = nil
        vim.notify('Clearing previous Rust binary name', vim.log.levels.DEBUG)
      end
      --
    end,
  },
}
