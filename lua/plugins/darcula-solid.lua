return {
  'santos-gabriel-dario/darcula-solid.nvim',
  lazy = false,
  priority = 1000,
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    vim.cmd.colorscheme('darcula-solid')
  end,
}
