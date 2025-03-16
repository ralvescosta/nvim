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

      local program_name
      function get_program_name()
        if not program_name then
          program_name = vim.fn.input('Enter program name: ', '')
        end
        return program_name
      end

      dap.configurations.rust = {
        {
          type = 'codelldb',
          request = 'launch',
          name = 'dynamic launcher',
          program = function()
            return string.format('${workspaceFolder}/target/debug/%s', get_program_name())
          end,
          cargo = {
            args = function()
              local pn = get_program_name()
              return { 'build', string.format('--bin=%s', pn), string.format('--package=%s', pn) }
            end,
            filter = {
              name = function()
                return get_program_name()
              end,
              kind = 'bin',
            },
          },
          env = {
            app_name = function()
              return get_program_name()
            end,
            rust_env = 'local',
            rust_backtrace = 'full',
          },
          cwd = '${workspaceFolder}',
        },
      }
      --
    end,
  },
}
