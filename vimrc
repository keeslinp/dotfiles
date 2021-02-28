" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/vim/plugged')

" Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"<Zig>
Plug 'ziglang/zig.vim'
"</Zig>
"<Flutter+Dart>
Plug 'dart-lang/dart-vim-plugin'
"</Flutter/Dart>
"
"<Kotlin>
Plug 'udalov/kotlin-vim'
"</Kotlin>

"<LSP>
" Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release' }
"</LSP>

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'yegappan/grep'

Plug 'haya14busa/incsearch.vim'

Plug 'easymotion/vim-easymotion'

Plug 'scrooloose/nerdcommenter'

" <Git>
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" </Git>

Plug 'rust-lang/rust.vim'

" nnn plugin
Plug 'mcchrish/nnn.vim'

" <JS>
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
" </JS>

Plug 'tpope/vim-abolish'

" Make sure you use single quotes

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf.vim'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'

Plug 'itchyny/lightline.vim'

Plug 'yggdroot/indentline'

Plug 'christoomey/vim-tmux-navigator'

Plug 'arcticicestudio/nord-vim'

" Initialize plugin system
call plug#end()

" map <C-n> :NERDTreeToggle<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" let g:NERDSpaceDelims = 1

map <C-n> :Np %:p:h<CR>

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-m>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-m>'           " replace visual C-n


set lazyredraw

set backspace=indent,eol,start

set wmh=0

map <Leader> <Plug>(easymotion-prefix)

syntax enable
colorscheme nord 

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

set updatetime=300

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype dart setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype c setlocal ts=2 sts=2 sw=2 expandtab
set ts=4 sts=4 sw=4 expandtab

set backupdir=~/.vim/swp
set directory=~/.vim/swp

set conceallevel=0
let g:vim_json_syntax_conceal = 0

set number
set synmaxcol=400

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Required for operations modifying multiple buffers like rename.
set hidden

let maplocalleader = "\\"

" <LSP>
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-rust-analyzer'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <c-n> coc#refresh()
nnoremap <silent> K :call CocAction('doHover')<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
nmap <leader>a  <Plug>(coc-codeaction)

nmap <leader>d  :<C-u>CocList diagnostics<cr>
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

nnoremap <silent> <C-s> :<C-u>CocList outline<cr>

" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>


" "<Rust>
" lua require'nvim_lsp'.rust_analyzer.setup{}
" "</Rust>
" "<TS>
" lua require'nvim_lsp'.tsserver.setup{}
" "</TS>


" </LSP>

" <Ack>
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif
" </Ack>

" Read the file if changed since last focus
set autoread
au FocusGained * :checktime

" Turn mouse support on
set mouse=a

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

" <Skim>
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
map <C-P> :Files <CR>
" map <C-P> :RG <CR>
" </Skim>


"<NVR>
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
endif
"</NVR>

