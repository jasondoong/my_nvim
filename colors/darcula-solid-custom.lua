vim.opt.background = 'dark'
vim.g.colors_name = 'darcula-solid-custom'

local lush = require('lush')
local darcula_solid = require('lush_theme.darcula-solid')

local spec = lush.extends({ darcula_solid }).with(function(injected_functions)
  local sym = injected_functions.sym
  -- Your modifications go here...
  -- Pallete copied from https://github.com/briones-gabriel/darcula-solid.nvim/blob/main/lua/lush_theme/darcula-solid.lua
  local yellow = lush.hsl(37, 100, 71)
  local selection = lush.hsl(0, 0, 55)
  local yank_bg = lush.hsl(30, 100, 55)

  return {
    -- Tree-sitter: class names in Python are captured as @type
    sym "@type" { fg = yellow },
    -- Constructor calls (e.g. Product()) are often captured as @constructor
    sym "@constructor" { fg = yellow },
    Visual { bg = selection },
    VisualNOS { bg = selection },
    YankHighlight { bg = yank_bg },
  }
end)

lush(spec)
