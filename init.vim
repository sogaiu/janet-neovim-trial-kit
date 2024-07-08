call plug#begin()

Plug 'morhetz/gruvbox'

Plug 'Olical/aniseed', { 'tag': 'v3.33.0' }

" :ConjureSchool
Plug 'pyrmont/conjure', { 'tag': 'feature.janet-mrepl' }

Plug 'bakpakin/janet.vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'HiPhish/rainbow-delimiters.nvim'

call plug#end()

" conjure's default is to use netrepl, but for the trial kit,
" using mrepl means less dependencies
let g:conjure#filetype#janet = 'conjure.client.janet.mrepl'

"-- adapted:
"--   https://github.com/janet-lang/janet.vim/blob/master/ftdetect/janet.vim
"-- au BufRead,BufNewFile *.janet,*.jdn setlocal filetype=janet

lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {"bash",
                      "c",
                      "html",
                      "janet_simple", "javascript",
                      "query"},
  highlight = {
    enable = true,
  },
}
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

