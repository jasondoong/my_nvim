return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    -- Telescope expects older nvim-treesitter APIs; add shims for Neovim 0.11.
    local ok_parsers, ts_parsers = pcall(require, 'nvim-treesitter.parsers')
    if ok_parsers and not ts_parsers.ft_to_lang then
      ts_parsers.ft_to_lang = function(ft)
        if vim.treesitter and vim.treesitter.language and vim.treesitter.language.get_lang then
          return vim.treesitter.language.get_lang(ft)
        end
        return ft
      end
    end
    if ok_parsers and not ts_parsers.get_parser then
      ts_parsers.get_parser = function(bufnr, lang)
        return vim.treesitter.get_parser(bufnr, lang)
      end
    end

    local ok_configs, ts_configs = pcall(require, 'nvim-treesitter.configs')
    if ok_configs then
      if not ts_configs.is_enabled then
        ts_configs.is_enabled = function(_, lang, bufnr)
          return pcall(vim.treesitter.get_parser, bufnr, lang)
        end
      end
      if not ts_configs.get_module then
        ts_configs.get_module = function(name)
          if name == 'highlight' then
            return { additional_vim_regex_highlighting = false }
          end
          return {}
        end
      end
    else
      package.loaded['nvim-treesitter.configs'] = {
        is_enabled = function(_, lang, bufnr)
          return pcall(vim.treesitter.get_parser, bufnr, lang)
        end,
        get_module = function(name)
          if name == 'highlight' then
            return { additional_vim_regex_highlighting = false }
          end
          return {}
        end,
      }
    end
  end,
}
