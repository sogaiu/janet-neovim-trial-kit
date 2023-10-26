" XXX: unfortunately duplicated here and in init.vim
call plug#begin()

Plug 'morhetz/gruvbox'

Plug 'folke/which-key.nvim'

" <leader>m or :Menu
Plug 'dstein64/vim-menu'

" :BSgrep <term> in combination with :Man <name> to search man pages
Plug 'jeetsukumaran/vim-buffersaurus'

Plug 'Olical/aniseed', { 'tag': 'v3.33.0' }

" :ConjureSchool
Plug 'sogaiu/conjure', { 'tag': 'janet-stdio' }

Plug 'bakpakin/janet.vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" :TSPlaygroundToggle
Plug 'nvim-treesitter/playground'

" :TSContextEnable
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'mfussenegger/nvim-lint'

Plug 'HiPhish/rainbow-delimiters.nvim'

call plug#end()

