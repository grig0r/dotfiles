"GCC
map <F8> :w<CR> :!clear; make %<<CR>
" map <F8> :w<CR> :!clear; g++ *.* -o main <CR>
map <F9> :!clear; ./%<<CR>

"MISC
filetype plugin indent on
set fileencodings=utf-8
set hidden
set path+=**
set wildmenu

"VISUAL
set background=dark
let base16colorspace=256
colorscheme base16-grayscale-dark
syntax on
set cursorline
set relativenumber
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal

"CLIPBOARD
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"AIRLINE
set laststatus=2
" let g:airline_theme='onedark'
" let g:airline_theme='dark'
let g:airline_theme='base16_grayscale'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

"NERDTREE
" let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowExpandable = '>'
" let g:NERDTreeDirArrowCollapsible = '◄'
let g:NERDTreeDirArrowCollapsible = '<'
map <C-n> :NERDTreeTabsToggle<CR>

"COMPLETIONS
filetype plugin on
set omnifunc=syntaxcomplete#Complete
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"neocomplcache
let g:neocomplcache_enable_at_startup = 1
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:acp_enableAtStartup = 0

"latex
filetype plugin on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

"PLUGINS
call plug#begin('~/.vim//plugged')

Plug 'ctrlpvim/ctrlp.vim'
" Plug 'ervandew/supertab'
" Plug 'https://github.com/vim-scripts/AutoComplPop'
Plug 'bling/vim-airline'
" Plug 'joshdick/airline-onedark.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
" Plug 'terryma/vim-multiple-cursors'
Plug 'plasticboy/vim-markdown'
" Plug 'vim-latex/vim-latex'
" Plug 'lervag/vimtex'
" Plug 'Shougo/neocomplcache.vim'
" Plug 'Rykka/riv.vim'
" Plug 'Rykka/InstantRst'
" Plug 'Valloric/YouCompleteMe'
Plug 'justinj/vim-react-snippets' | Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'Shougo/neocomplete.vim'
Plug 'jeetsukumaran/vim-buffergator'
" Plug 'jlanzarotta/bufexplorer'
Plug 'jceb/vim-orgmode'
Plug 'c9s/perlomni.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'

call plug#end()

" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsEditSplit="vertical"

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" [10] make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'
"
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
if !exists('g:neocomplete#keyword_patterns')
	    let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
-

" AUTOPAIRS
let g:AutoPairsShortcutToggle = '<leader>a'
let g:AutoPairsFlyMode = 1

" cucumber
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
