return {
  'santos-gabriel-dario/darcula-solid.nvim',
  lazy = false,
  priority = 1000,
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    -- Use customized darcula-solid theme overrides.
    vim.cmd.colorscheme('darcula-solid-custom')
  end,
}
