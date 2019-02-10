" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/vim/plugged')

Plug 'reasonml-editor/vim-reason-plus'

Plug 'gaalcaras/ncm-R'

Plug 'vigemus/iron.nvim'

Plug 'w0rp/ale'

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

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
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
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

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <c-n> coc#refresh()
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Setup formatexpr specified filetype(s).
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

nnoremap <silent> <C-s> :<C-u>CocList -I outline<cr>

let g:notes_directories = ['~/Dropbox/School Work/Fall2018/ARTHC/notes/']
autocmd BufRead,BufNewFile *.note setlocal spell
let g:notes_suffix = '.note'

compiler cargo

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

autocmd FileType make setlocal noexpandtab

call coc#config("languageserver", {
\  'ccls': {
\   'command': 'ccls',
\    'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
\    'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
\    'initializationOptions': {
\      'cacheDirectory': '/tmp/ccls'
\    }
\  }
\})
