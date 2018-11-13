" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/vim/plugged')

Plug 'reasonml-editor/vim-reason-plus'

Plug 'gaalcaras/ncm-R'

Plug 'vigemus/iron.nvim'

Plug 'w0rp/ale'

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }

Plug 'mileszs/ack.vim'

Plug 'haya14busa/incsearch.vim'

Plug 'easymotion/vim-easymotion'

Plug 'scrooloose/nerdcommenter'

Plug 'airblade/vim-gitgutter'

Plug 'rust-lang/rust.vim'

Plug 'mxw/vim-jsx'

" Make sure you use single quotes

Plug 'altercation/vim-colors-solarized'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'itchyny/lightline.vim'

Plug 'yggdroot/indentline'

Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
" Note taking plugin
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
" Initialize plugin system
call plug#end()

map <C-P> :Files <CR>
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDSpaceDelims = 1

set lazyredraw

set backspace=indent,eol,start

set wmh=0

map <Leader> <Plug>(easymotion-prefix)

syntax enable
set background=dark
colorscheme solarized

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

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype c setlocal ts=2 sts=2 sw=2 expandtab
set ts=4 sts=4 sw=4 expandtab

set backupdir=~/.vim/swp
set directory=~/.vim/swp

set conceallevel=0
let g:vim_json_syntax_conceal = 0

set number
set synmaxcol=400

let g:deoplete#enable_at_startup = 1
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'java': ['java-lang-server'],
    \ 'dart': ['dart_language_server'],
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'python': ['pyls', '-v'],
    \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
    \ 'reason': ['reason-language-server.exe'],
    \ }

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()
" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
noremap <silent> <C-s> :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F3> :call LanguageClient_textDocument_formatting()<CR>

let g:notes_directories = ['~/Dropbox/School Work/Fall2018/ARTHC/notes/']
autocmd BufRead,BufNewFile *.note setlocal spell
let g:notes_suffix = '.note'

compiler cargo

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

autocmd FileType make setlocal noexpandtab
