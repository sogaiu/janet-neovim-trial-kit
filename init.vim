call plug#begin()

Plug 'morhetz/gruvbox'

Plug 'folke/which-key.nvim'

Plug 'Olical/aniseed', { 'tag': 'v3.33.0' }

" :ConjureSchool
Plug 'Olical/conjure', { 'tag': 'v4.49.0' }

Plug 'bakpakin/janet.vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" :TSPlaygroundToggle
Plug 'nvim-treesitter/playground'

Plug 'mfussenegger/nvim-lint'

Plug 'HiPhish/rainbow-delimiters.nvim'

" usable vim-sexp
Plug 'guns/vim-sexp'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

call plug#end()

" for using stdio with janet instead of netrepl
let g:conjure#filetype#janet = 'conjure.client.janet.stdio'

lua << EOF
require('which-key').setup()
EOF

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
  -- playground
  playground = {
    enable = true,
    disable = {},
    -- Debouncing for highlighting nodes in playground from source code
    updatetime = 25,
    -- Whether the query persists across vim sessions
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
EOF

lua << EOF
-- manually triggering -> :lua require("lint").try_lint()
require('lint').linters_by_ft = {
  --janet = {'janet', 'rjan'},
  janet = {'janet'},
}
EOF

lua << EOF
-- TextChangedI might be worth trying at some point
vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
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

" so vim-sexp stuff works for janet
let g:sexp_filetypes = 'clojure,scheme,lisp,timl,janet'

colorscheme gruvbox

set number

" conjure's recommendation
let maplocalleader = ','

