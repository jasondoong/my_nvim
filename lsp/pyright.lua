return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  capabilities = (function()
    local ok, cmp = pcall(require, "cmp_nvim_lsp")
    if ok then
      return cmp.default_capabilities()
    end
    return vim.lsp.protocol.make_client_capabilities()
  end)(),
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
      },
    },
  },
}
