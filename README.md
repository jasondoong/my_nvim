# My Neovim Config

Minimal overview of how this Neovim setup is organized and where to place new code.

## Directory Structure

```
~/.config/nvim/
├── init.lua          # Entry point (options, keymaps, and loader)
├── lua/              # Your custom modules
│   ├── config/       # Basic settings (options, autocmds, etc.)
│   └── plugins/      # Plugin-specific configurations
└── lsp/              # [NEW in 0.11] Native LSP config files (e.g., basedpyright.lua)
```

## Notes

- Keep personal modules under `lua/` to avoid conflicts with upstream plugins.
- The `lsp/` directory uses Neovim 0.11's native loader; drop per-language files (like `basedpyright.lua`) there.
- Reload changes with `:source init.lua` or restart Neovim to pick them up.
- Telescope requires `ripgrep` for live grep.
- Install Python treesitter parser with `:TSInstall python`.


### macOS install

```sh
brew install ripgrep
```

Mason installs these for you:

```
lua-language-server
tree-sitter-cli
basedpyright
lua_ls
```
