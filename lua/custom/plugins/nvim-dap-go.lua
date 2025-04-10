return {
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function(_, _)
      require('dap-go').setup {
        dap_configurations = {
          {
            type = 'go',
            name = 'Debug with dynamic args',
            request = 'launch',
            program = '${workspaceFolder}/main.go',
            outputMode = 'remote',
            args = require('dap-go').get_arguments,
            env = {
              GOPRIVATE = 'bitbucket.org/asappay',
              ENVIRONMENT = 'dev',
              SERVICE_NAME = 'go-acquirer-local-service',
              OTEL_EXPORTER_OTLP_ENDPOINT = 'localhost:4317',
              AWSPROFILE = 'asappay-dev',
              SOME_VAR = 'value',
            },
          },
        },
      }
    end,
  },
}
