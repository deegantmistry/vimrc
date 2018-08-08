" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

"" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'
"
"" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
"" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'Shougo/context_filetype.vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh && npm install -g javascript-typescript-langserver && pip3 install python-language-server',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'


if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif


"
"" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
"" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }
"
"" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
"" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
"" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""
" LSP - Language Server Protocol
" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Minimal LSP configuration for JavaScript
let g:LanguageClient_serverCommands = {}

if executable('pyls')
    let g:LanguageClient_serverCommands.python = ['pyls']
    " Use LanguageServer for omnifunc completion
    autocmd FileType python setlocal omnifunc=LanguageClient#complete
else
    echo "pyls not available!\n"
    :cq
endif

if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  " Use LanguageServer for omnifunc completion
  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
else
  echo "javascript-typescript-stdio not installed!\n"
  :cq
endif

autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags


" <leader>ld to go to definition
autocmd FileType javascript nnoremap <buffer>
  \ <tab>dd :call LanguageClient_textDocument_definition()<cr>
" <leader>lh for type info under cursor
autocmd FileType javascript nnoremap <buffer>
  \ <leader>lh :call LanguageClient_textDocument_hover()<cr>
" <leader>lr to rename variable under cursor
autocmd FileType javascript nnoremap <buffer>
  \ <leader>lr :call LanguageClient_textDocument_rename()<cr>


nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

""""""""""""""""""""""""""""""""""""""""
" deoplete
let g:deoplete#enable_at_startup = 1
"let g:deoplete#disable_auto_complete = 1

" deoplete go down on list
inoremap <expr><c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
" deoplete go up on list
inoremap <expr><c-k> pumvisible() ? "\<c-p>" : "\<c-k>"

inoremap <c-space> <c-x><c-o>
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

filetype plugin indent on
syntax enable

set encoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""

set runtimepath^=~/.vim/plugged/ctrlp.vim


"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"

let g:UltiSnipsEditSplit="vertical"

" YouCompleteMe and UltiSnips compatibility.
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']

        "if has('autocmd')
        "  augroup WincentAutocomplete
        "    autocmd!
        "    autocmd! User UltiSnipsEnterFirstSnippet
        "    autocmd User UltiSnipsEnterFirstSnippet call autocomplete#setup_mappings()
        "    autocmd! User UltiSnipsExitLastSnippet
        "    autocmd User UltiSnipsExitLastSnippet call autocomplete#teardown_mappings()
        "  augroup END
        "endif

"let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
"let g:ycm_key_list_accept_completion = ['<C-y>']

" Additional UltiSnips config.
let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = ['ultisnips']


set visualbell
set tabstop=4 shiftwidth=4 expandtab
let g:ctrlp_map = '<c-p>'
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
set nu
inoremap jj <ESC>
nmap <tab>s ysiw
nmap <TAB>h :tabp<cr>
nmap <tab>l :tabn<cr>
nmap <tab>n :set nu<cr>

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" When jump to next match also center screen
nnoremap n nzz
nnoremap N Nzz
vnoremap n nzz
vnoremap N Nzz

set relativenumber
nmap <tab>nn :set nonu<cr>
nmap <tab><space> :tabedit<space>
nmap <tab>b :!bash<cr>
syntax on
:colorscheme torte
nmap <tab>m :NERDTree<space>
set splitbelow
set splitright

"search down into dirs and sub dirs
set path+=**

