" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/vim/plugged')

Plug 'w0rp/ale'

Plug 'haya14busa/incsearch.vim'

Plug 'easymotion/vim-easymotion'

Plug 'scrooloose/nerdcommenter'

Plug 'airblade/vim-gitgutter'

Plug 'rust-lang/rust.vim'


" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'altercation/vim-colors-solarized'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'itchyny/lightline.vim'

Plug 'yggdroot/indentline'

Plug 'ternjs/tern_for_vim', { 'do': 'npm i' }

Plug 'pangloss/vim-javascript'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
" Initialize plugin system
call plug#end()

map <C-P> :Files <CR>
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDSpaceDelims = 1

set lazyredraw

set backspace=indent,eol,start

set wmh=0

map <C-H> :bprevious<CR>
map <C-L> :bnext<CR>
nmap <leader>q :bp <BAR> bd #<CR>
nmap <leader>T :enew<cr>


map <Leader> <Plug>(easymotion-prefix)

syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors = 256  " New line!!

let g:lightline = {
			\ 'colorscheme': 'solarized',
			\}

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

nnoremap <C-S-j> :m .+1<CR>==
nnoremap <C-S-k> :m .-2<CR>==
inoremap <C-S-j> <Esc>:m .+1<CR>==gi
inoremap <C-S-k> <Esc>:m .-2<CR>==gi
vnoremap <C-S-j> :m '>+1<CR>gv=gv
vnoremap <C-S-k> :m '<-2<CR>gv=gv

set updatetime=250

let g:UltiSnipsExpandTrigger="<C-CR>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab

set backupdir=~/.vim/swp
set directory=~/.vim/swp

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

set conceallevel=0
let g:vim_json_syntax_conceal = 0

set number
set hid

let g:deoplete#enable_at_startup = 1
set clipboard=unnamed
