# My Neovim Config

Minimal overview of how this Neovim setup is organized and where to place new code.

## Directory Structure

```
~/.config/nvim/
├── init.lua          # Entry point (options, keymaps, and loader)
├── lua/              # Your custom modules
│   ├── config/       # Basic settings (options, autocmds, etc.)
│   └── plugins/      # Plugin-specific configurations
└── lsp/              # [NEW in 0.11] Native LSP config files (e.g., pyright.lua)
```

## Notes

- Keep personal modules under `lua/` to avoid conflicts with upstream plugins.
- The `lsp/` directory uses Neovim 0.11's native loader; drop per-language files (like `pyright.lua`) there.
- Reload changes with `:source init.lua` or restart Neovim to pick them up.
