return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'python', 'lua', 'vim', 'vimdoc' },
    auto_install = true,
    highlight = { enable = true },
  },
  config = function()
    -- Enable Tree-sitter highlighting when opening Python buffers.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'python',
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
