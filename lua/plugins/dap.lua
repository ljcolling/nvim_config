return {
  "williamboman/mason.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    require("mason").setup()
    require("mason-nvim-dap").setup()
    require("dapui").setup()

    require("dap-python").setup('/Users/lc663/.config/nvim/.venv/bin/python')



    local dap = require('dap')
    dap.configurations.python = {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          return '/Users/lc663/.config/nvim/.venv/bin/python'
        end;
      },
    }

  end

}
