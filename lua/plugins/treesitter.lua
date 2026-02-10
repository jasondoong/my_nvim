return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'python', 'lua', 'vim', 'vimdoc' },
    auto_install = true,
    highlight = { enable = true },
  },
}
