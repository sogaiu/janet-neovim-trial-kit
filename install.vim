" XXX: unfortunately duplicated here and in init.vim
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

