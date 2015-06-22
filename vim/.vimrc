set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'derekwyatt/vim-scala'
Plugin 'spwhitt/vim-nix'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on


" basic options
set t_vb=
set t_Co=16
set novisualbell
set noerrorbells
set autoindent
set mouse=a
set incsearch
set shiftwidth=2
set sts=2
set expandtab
set nowrap
set gdefault
set tw=78                     " default textwidth is a max of 78
set list                      " enable custom list chars
set listchars=tab:▸\ ,extends:❯,precedes:❮    " replace tabs, eol
set showbreak=↪               " show breaks
set colorcolumn=+1
set number
syntax enable
let g:solarized_termcolors=256
let g:solarized_contrast="high"    "default value is normal
" let g:solarized_hitrail=1
set background=dark
colorscheme solarized
filetype plugin on

" Temporary files
set directory=~/tmp/vim/
set undofile
set undodir=~/tmp/vim/
set backup
set backupdir=~/tmp/vim/
set backupskip=~/tmp/vim/
set writebackup

" ensure that buffer position is restored
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Ctrl-P configuration
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files --exclude-standard']

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Quick commands using leader sequences
let mapleader=","
map <Leader>a :Tabularize //<Left>
map <Leader>p :CtrlPBuffer<CR>
map <Leader>t :NERDTreeToggle<CR>
map <Leader>w :StripWhitespace<CR>:w<CR>
map <Leader>gs :GStatus<CR>

" Grep options
autocmd QuickFixCmdPost *grep* cwindow " Always open the quickfix window when grepping

" Git grep. Example usage:
" :GG -i 'foobar' -- lib/*.hs
" Grep case-insensitively for the string 'foobar', searching all haskell
" source files located (recursively) under the 'lib' directory.
if !exists(':GG')
  " Ggrep! = git grep without automatically jumping to the first match
  command -nargs=+ GG silent Ggrep! <args>
endif

" Fast searching for word under cursor
map <Leader>gg :GG <cword><CR>
map <Leader>f :cnext<CR>
map <Leader>b :cprevious<CR>

" *.md is Markdown, I don't write Modula2 files ;-)
autocmd BufNewFile,BufRead *.md set filetype=markdown
