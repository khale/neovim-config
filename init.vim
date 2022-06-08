call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdcommenter' " for quick commenting hot keys
Plug 'majutsushi/tagbar'        " tag listing
Plug 'scrooloose/nerdtree'      " file tree
Plug 'tpope/vim-fugitive'       " Git integration
Plug 'vim-airline/vim-airline' " status bar
Plug 'flazz/vim-colorschemes'   " color schemes
Plug 'sonph/onehalf', { 'rtp': 'vim' } " colorscheme
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " multiple cursors
Plug 'dyng/ctrlsf.vim' " search across multiple files (use with multiple cursors)
Plug 'ibhagwan/fzf-lua', {'branch': 'main'} " fzf integration (CtrlP replacement)
Plug 'kyazdani42/nvim-web-devicons' " optional for icon support
Plug 'junegunn/vim-easy-align' " aligning text with ,maq
Plug 'voldikss/vim-floaterm'
Plug 'mbbill/undotree'
Plug 'JuliaEditorSupport/julia-vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'github/copilot.vim', {'branch': 'release'} 

call plug#end()


let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = "dark"

" show line numbers
set number

"colorscheme molokai
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

" better filename completion in vim command line
set wildmode=list:longest,full

" underline!
set cursorline
"set cursorcolun

" Search/replace word under cursor (,s)
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" tell me when i'm in insert or visual mode
set showmode

" don't ding at me
set noerrorbells
set novisualbell 

" where to put swp files
set directory=~/.vim/tmp/swp//,~/.tmp//,/tmp//

" don't create foo~ files
set nobackup

" to try to get rid of 'hit ENTER to continue' prompts
set shortmess=a
set cmdheight=1

" always give me at least 3 lines before and after cursor
set scrolloff=3

" tab settings
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" remap ; to : in command mode and replace it with , (saves a key press)
nore ; :
nore , ;


" avoid that damn "no write since last change" warning when
" switching buffers
set hidden

set shell=/opt/homebrew/bin/fish
set lazyredraw  " don't redraw when we don't have to

" aesthetics
set background=dark

" with these, if you include capitals in a search it'll do
" the right thing, if you just use lowercase,
" it'll be case insensitive
set ignorecase
set smartcase

" %s/p/r -> %s/p/r/g
set gdefault

set showmatch
" but allow me to get rid of the highlighting afterwards with ,space
nnoremap <CR> :noh<CR>
set hls!

" line wrapping
"set wrap
"set textwidth=80
set formatoptions=qrtn1
" tell me when i'm running on too long
"highlight OverLength ctermbg=red 
"ctermfg=white
"match OverLength /\%80v.\+/

"set up code folding
set nofoldenable     "don't fold by default
set foldmethod=indent   " fold on indentations
set foldnestmax=10   "only fold up to 10 levels
set foldlevel=1     " only show me first fold level


nnoremap j gj
nnoremap k gk
nnoremap <right> :bn<CR>
nnoremap <left>  :bp<CR>
inoremap <right> <ESC>:bn<CR>
inoremap <left>  <ESC>:bp<CR>

" save buffers when we move away from vim
"au FocusLost * :wa


" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
"set smartindent


" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
" set viminfo='10,\"100,:20,%,n~/.viminfo

" do the restore
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	au BufWinEnter * call ResCur()
augroup END


" === KEY MAPPINGS ===

" change <leader> key. defaults is '\', hard to reach
let mapleader=","


" quick window split with ,s[vh] (vertical, horizontal)
nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>sh <C-w>s<C-w>j

" move around splits faster
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" move around tabs faster
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>t1 :tabn 1<CR>
nnoremap <leader>t2 :tabn 2<CR>
nnoremap <leader>t3 :tabn 3<CR>
nnoremap <leader>t4 :tabn 4<CR>

" key mapping to toggle spell checker (apparently this will do the right thing in
" source files. Use zg to whitelist a word
nnoremap <leader>sp :set invspell<CR>


" let me edit my vimrc quickly with ,ev
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>

" autoreload vimrc when it's edited
autocmd! bufwritepost vimrc source ~/.vim/vimrc

" quickly reload vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" quicker than reaching for escape
inoremap jj <ESC>

" quick save
nnoremap <leader>w :w<CR>

" sudo save
cnoremap w!! w !sudo tee % > /dev/null

set title

" Insert a lambda: mostly for scheme and haskell
imap <C-Bslash> λ

" Use better syntax highlighting for ASM
let g:asmsyntax="asmx86"


" =======================
" PLUGIN-SPECIFIC OPTIONS
" =======================

" ++++++++++ TagBar ++++++++++++
"make TagBar a little easier: press ',1' in command mode to bring it up
let g:tagbar_usearrows = 1
nnoremap <leader>1 :TagbarToggle<CR>
" Uncomment this line to open Tagbar on startup for code files
" au BufRead *.[ch],*.cpp,*.java,*.js,*.py,*.pl TagbarOpen
" !++++++++++ TagBar ++++++++++++!

" ++++++++ NERDTree ++++++++++
nnoremap <leader>2 :NERDTreeToggle<CR>
" !++++++++ NERDTree ++++++++++!


" +++++++ Undotree ++++++++++
nnoremap <F5> :UndotreeToggle<cr>


let g:python_host_prog = "/opt/homebrew/bin/python3"


" !+++++++++ fzf-lua ++++++++++!
nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <c-G> <cmd>lua require('fzf-lua').live_grep_native()<CR>
nnoremap <c-E> <cmd>lua require('fzf-lua').grep_cword()<CR>

" +++++++++ CtrlSF ++++++++++++++++++
nmap     <C-S>n <Plug>CtrlSFPrompt
vmap     <C-S>f <Plug>CtrlSFVwordPath<CR>
vmap     <C-S>F <Plug>CtrlSFVwordExec<CR>
nmap     <C-S>f <Plug>CtrlSFCwordPath<CR>
nmap     <C-S>p <Plug>CtrlSFPwordPath<CR>
nnoremap <C-S>o :CtrlSFOpen<CR>
nnoremap <C-S>t :CtrlSFToggle<CR>
inoremap <C-S>t <Esc>:CtrlSFToggle<CR>



" +++++++++ NeoTex ++++++++++++++++++
let g:neotex_enabled = 2
let g:tex_flavor = 'latex'
let g:neotex_latexdiff = 1
let g:neotex_delay = 400

" +++++++++ FloatTerm ++++++++++++++++++
" Configuration example
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ma <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ma <Plug>(EasyAlign)


let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]   = '<C-j>'
let g:VM_maps["Add Cursor Up"]     = '<C-k>'
