call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bronson/vim-trailing-whitespace'
Plug 'altercation/vim-colors-solarized'

call plug#end()

set background=dark
try
    colorscheme solarized
catch
endtry
