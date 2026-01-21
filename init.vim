call plug#begin()

Plug 'morhetz/gruvbox'

" :ConjureSchool
Plug 'Olical/conjure'

" mrepl / grapple
Plug 'Olical/nfnl'
Plug 'pyrmont/grapple', { 'rtp': 'res/plugins/grapple.nvim' }

Plug 'bakpakin/janet.vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'HiPhish/rainbow-delimiters.nvim'

call plug#end()

" use mrepl / grapple
let g:conjure#filetype#janet = 'grapple.client'

"-- adapted:
"--   https://github.com/janet-lang/janet.vim/blob/master/ftdetect/janet.vim
"-- au BufRead,BufNewFile *.janet,*.jdn setlocal filetype=janet

lua << EOF
require('nvim-treesitter').install {
  'bash',
  'c',
  'html',
  'janet_simple', 'javascript',
  'query'
}
EOF

lua << EOF
vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'bash',
      'c',
      'html',
      'janet_simple', 'javascript',
      'query'
    },
    callback = function()
      -- syntax highlighting, provided by Neovim
      vim.treesitter.start()
    end,
  })
EOF

lua << EOF
-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}
EOF

colorscheme gruvbox

set number

" conjure's recommendation
let maplocalleader = ','

