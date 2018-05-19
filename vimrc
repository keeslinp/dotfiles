" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/vim/plugged')

Plug 'peterhoeg/vim-qml'

" Plug 'w0rp/ale'

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }

Plug 'mileszs/ack.vim'

" (Optional) Multi-entry selection UI.
Plug 'Shougo/denite.nvim'

" (Optional) Completion integration with nvim-completion-manager.
Plug 'roxma/nvim-completion-manager'

" (Optional) Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

Plug 'neomake/neomake'
Plug 'benjie/neomake-local-eslint.vim'

Plug 'haya14busa/incsearch.vim'

Plug 'easymotion/vim-easymotion'

Plug 'scrooloose/nerdcommenter'

Plug 'airblade/vim-gitgutter'

Plug 'rust-lang/rust.vim'

Plug 'mxw/vim-jsx'

" Make sure you use single quotes

Plug 'altercation/vim-colors-solarized'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'itchyny/lightline.vim'

Plug 'yggdroot/indentline'

" Plug 'ternjs/tern_for_vim', { 'do': 'npm i' }

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

map <C-H> :bprevious<CR>
map <C-L> :bnext<CR>
nmap <leader>q :bp <BAR> bd #<CR>
nmap <leader>T :enew<cr>


map <Leader> <Plug>(easymotion-prefix)

syntax enable
set background=dark
colorscheme solarized
" let g:solarized_termcolors = 256  " New line!!

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

let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost,BufEnter * Neomake

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
set ts=4 sts=4 sw=4 expandtab

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
set synmaxcol=400

let g:deoplete#enable_at_startup = 1
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'java': ['java-lang-server'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
noremap <silent> <C-s> :call LanguageClient_textDocument_documentSymbol()<CR>

let g:notes_directories = ['~/Dropbox/School Work/Winter 2018/REL225/']
autocmd BufRead,BufNewFile *.note setlocal spell
let g:notes_suffix = '.note'

compiler cargo

if executable('ag')
  let g:ackprg = 'ag --vimgrep --ignore-dir dist'
endif
