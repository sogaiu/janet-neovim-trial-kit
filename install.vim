" XXX: unfortunately duplicated here and in init.vim
call plug#begin()

Plug 'morhetz/gruvbox'

Plug 'Olical/aniseed', { 'tag': 'v3.33.0' }

" :ConjureSchool
Plug 'pyrmont/conjure', { 'tag': 'feature.janet-mrepl' }

Plug 'bakpakin/janet.vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'HiPhish/rainbow-delimiters.nvim'

call plug#end()

