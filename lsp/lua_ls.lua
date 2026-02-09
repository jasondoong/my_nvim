return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  capabilities = (function()
    local ok, cmp = pcall(require, "cmp_nvim_lsp")
    if ok then
      return cmp.default_capabilities()
    end
    return vim.lsp.protocol.make_client_capabilities()
  end)(),
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".git",
  },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}
