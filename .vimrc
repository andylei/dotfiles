" Install Vundle first!

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

 " let Vundle manage Vundle
 " required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
Bundle 'scrooloose/syntastic'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jnwhiteh/vim-golang'
Bundle 'andylei/allhallowseve'

Bundle 'bufkill.vim'
Bundle 'python.vim'

filetype plugin indent on

if has("gui_running")
  colorscheme allhallowseve
  set listchars=tab:ª\ ,eol:¨
else
  colorscheme default
endif

let python_highlight_string_formatting = 1
let python_highlight_string_format = 1
let python_highlight_string_templates = 1
let g:syntastic_enable_signs = 1

" put all swap files in the same place
set directory^=C:\temp,$HOME/.vim_swap//

syntax on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab

set smartcase " ignore case when pattern is all lowercase, sensitive otherwise
set hlsearch  " highlight search terms
set incsearch " show matches as you type
set visualbell "don't beep
set noerrorbells "don't beep

" keep 4 visible lines around the cursor always
set scrolloff=4

" status line
set statusline=%f%m%r%h%w\ [%Y\ %{&ff}]\ [%c\ %l/%L\ (%p%%)]
set laststatus=2

" line numbers
set number

set hidden


set fileformats=unix,dos

" ignore .class and .pyc files
set wildignore=*.pyc,*.class
" bash style completion
set wildmode=longest,list,full
set wildmenu

" backspaces delete things
set backspace=2

" lets you switch out of unsaved buffers
set hidden

" automagically save / restore folds
au BufWinLeave *.* mkview
au BufWritePost *.* mkview
au BufWinEnter *.* silent loadview

" show invisibles
set list

" remove tool, menu, and scroll bars from gvim
set guioptions-=m
set guioptions-=T
set guioptions+=Lrbl
set guioptions-=Lrbl

" enable alt space, perhaps even alt tab
set winaltkeys=yes

" gvim font
set guifont=Consolas:h10

set gdefault " makes /g searches happen by default

set clipboard=unnamed " automatically yank to the windows clipboard

" Middle Mouse button pastes all the time on accident
" Apparently double / triple / quadruple middle mouse click also pastes
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" F3 => tell me what highlight group it is
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap j gj
nnoremap k gk

" single char deletes don't update default register
noremap x "_x
" paste doesn't update default register
vnoremap p "_dP

" Control-n => NERDTree
nmap <silent> <c-n> :NERDTreeToggle<CR>
" NERDTree should ignore pyc files
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$']

" superfast commands
nnoremap ; :

let mapleader = ","
" ,/ => clear search buffer
nmap <silent> <LEADER>/ :let @/=""<CR>
" ,c => cd to current file
nmap <LEADER>c :lcd %:p:h<CR>
nmap <LEADER>C :cd %:p:h<CR>

" make space toggle folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" buffer next, prev
nnoremap <silent> ˚ :bp<CR>
nnoremap <silent> ˝ :bn<CR>

" F12 => redo syntax highlighting
noremap <F12> <Esc>:syntax sync fromstart<CR>

" F11 => full screen
if has("gui_running")
  map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR> 
endif

function! SetTab(num)
  let num = a:num
  execute('set shiftwidth='.num)
  execute('set softtabstop='.num)
  execute('set tabstop='.num)
endfunction

if has("python")
" Let me use gf on python libraries
python << EOF
import os
import sys
import vim
for p in sys.path:
  if os.path.isdir(p):
    vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
endif

