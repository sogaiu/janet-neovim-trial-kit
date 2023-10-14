call plug#begin()

Plug 'morhetz/gruvbox'

Plug 'folke/which-key.nvim'

" <leader>m or :Menu
Plug 'dstein64/vim-menu'

" :BSgrep <term> in combination with :Man <name> to search man pages
Plug 'jeetsukumaran/vim-buffersaurus'

Plug 'Olical/aniseed', { 'tag': 'v3.33.0' }

" :ConjureSchool
Plug 'Olical/conjure', { 'tag': 'v4.48.0' }

Plug 'bakpakin/janet.vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" :TSPlaygroundToggle
Plug 'nvim-treesitter/playground'

" :TSContextEnable
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'mfussenegger/nvim-lint'

call plug#end()

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
                      "janet_simple", "javascript"},
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
require'treesitter-context'.setup{
  -- Enable this plugin (Can be enabled/disabled later via commands)
  enable = true,
  -- How many lines the window should span. Values <= 0 mean no limit.
  max_lines = 0,
  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  min_window_height = 0,
  line_numbers = true,
  -- Maximum number of lines to show for a single context
  multiline_threshold = 20,
  -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  trim_scope = 'outer',
  -- Line used to calculate context. Choices: 'cursor', 'topline'
  --mode = 'cursor',
  mode = 'topline',
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  -- The Z-index of the context window
  zindex = 20,
  -- (fun(buf: integer): boolean) return false to disable attaching
  on_attach = nil,
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

colorscheme gruvbox

set number

" XXX: vim-menu plugin makes this unneeded?
" menus available via `:emenu <TAB>`
"source $VIMRUNTIME/menu.vim

" for the :Man command
runtime! ftplugin/man.vim

" conjure's recommendation
let maplocalleader = ','
