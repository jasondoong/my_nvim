return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.files').setup({
      mappings = {
        go_in_plus= '<CR>',
      },
    })

    -- Simple and easy statusline.
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup {
      use_icons = vim.g.have_nerd_font,
      content = {
        inactive = function()
          local pathname= MiniStatusline.section_filename({trunc_width= 100})
          return MiniStatusline.combine_groups({
            { hl = 'MiniStatuslineFilename', strings = { pathname } },
          })
        end,
      }
    }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
