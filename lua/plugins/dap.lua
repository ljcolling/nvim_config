return {
  "williamboman/mason.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui"
  },
  config = function()
    require("mason").setup()
    require("mason-nvim-dap").setup()
    require("dapui").setup()


    local dap = require('dap')
    dap.configurations.python = {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          return '/usr/bin/python'
        end;
      },
    }

  end

}
