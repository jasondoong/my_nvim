return {
  {
    name = 'my_pytest',
    dir = vim.fn.stdpath('config'),
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('my_pytest')
    end,
  },
}
