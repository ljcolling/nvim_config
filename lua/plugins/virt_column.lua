

return  {
  "lukas-reineke/virt-column.nvim",
  lazy = false,
  config = function()

require('virt-column').setup({ char = "│" })
vim.cmd([[
   highlight VirtText guifg=#ff0000 guibg=#000000
 ]])

 end
 }
