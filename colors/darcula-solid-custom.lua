vim.opt.background = 'dark'
vim.g.colors_name = 'darcula-solid-custom'

local lush = require('lush')
local darcula_solid = require('lush_theme.darcula-solid')

local spec = lush.extends({ darcula_solid }).with(function(injected_functions)
  local sym = injected_functions.sym
  -- Your modifications go here...
  -- Pallete copied from https://github.com/briones-gabriel/darcula-solid.nvim/blob/main/lua/lush_theme/darcula-solid.lua
  local yellow = lush.hsl(37, 100, 71)

  return {
    -- Tree-sitter: class names in Python are captured as @type
    sym "@type" { fg = yellow },
    -- Constructor calls (e.g. Product()) are often captured as @constructor
    sym "@constructor" { fg = yellow },
  }
end)

lush(spec)
