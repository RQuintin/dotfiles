" Purpose: Set appropriate defaults
" Author:  Simon Meier
" Date:    2005/11/2
" Updated: 2013/02/09

" use pathogen to manage vim plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" basic options
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
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮    " replace tabs, eol
set showbreak=↪               " show breaks
set colorcolumn=+1
set number
syntax enable
set background=dark
" colorscheme solarized
filetype plugin on

" ---------------------------------------------------------------------------
"  configurations for vim or gvim only
if !has("gui_running")
    set background=dark
    colorscheme darkblue
    " let g:AutoClosePreservDotReg=0
end
if has("gui_running")
    set background=dark
    colorscheme solarized

    "let rdark_current_line=1  " highlight current line
    "set noantialias
    "set lines=64
    "set columns=135
    "set transparency=0
    "set gfn=Monaco:h9.0
    "set gfn=Menlo:h10.0

    set guioptions-=T        " no toolbar
    set guioptions-=m        " no menubar
    set guioptions-=l        " no left scrollbar
    set guioptions-=L        " no left scrollbar
    set guioptions-=r        " no right scrollbar
    set guioptions-=R        " no right scrollbar
    set clipboard=unnamed
end

" Tabularize remaps
:nnoremap <F2>j :Tabularize /\( \\|^\)->\( \\|$\)/l0<CR>
:nnoremap <F2>k :Tabularize /\( \\|^\)<-\( \\|$\)/l0<CR>
:nnoremap <F2>l :Tabularize /\( \\|^\)=\( \\|$\)/l0<CR>
                                  
:vnoremap <F2>j :Tabularize /\( \\|^\)->\( \\|$\)/l0<CR>
:vnoremap <F2>k :Tabularize /\( \\|^\)<-\( \\|$\)/l0<CR>
:vnoremap <F2>l :Tabularize /\( \\|^\)=\( \\|$\)/l0<CR>

" filetype for .ML files
au! BufRead,BufNewFile *.ML         setfiletype sml

" mapping for calling make
map <F7> :w<CR>:!pdflatex %<CR>
map <F8> :w<CR>:!make<CR>

" NerdTree
map <F9> :NERDTreeToggle<CR>
" BufExplorer
map <F11> :BufExplorer<CR>

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

" Use alt-cursors to flip between windows
map <A-Up> <C-W><Up>
map <A-Down> <C-W><Down>
map <A-Left> <C-W><Left>
map <A-Right> <C-W><Right>
map <A-c> <C-W>c

" Change to the directory the file in your current buffer is in
"autocmd BufEnter * :lcd %:p:h
" From http://www.vim.org/tips/tip.php?tip_id=370
" autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /

" Removing trailing whitespace
""""""""""""""""""""""""""""""

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    let _s=@/ 
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfun

autocmd BufWritePre *.h *.c *.hs *.lhs :call <SID>StripTrailingWhitespaces()

" Filetype stuff
""""""""""""""""



" Latex
au FileType tex         setlocal autowrite
au FileType tex         setlocal efm=%E!\ LaTeX\ %trror:\ %m,
        \%E!\ %m,
        \%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#,
        \%-GOverfull\ %m,
        \%-GUnderfull\ %m,
        \%+W%.%#\ at\ lines\ %l--%*\\d,
        \%WLaTeX\ %.%#Warning:\ %m,
        \%Cl.%l\ %m,
        \%+C\ \ %m.,
        \%+C%.%#-%.%#,
        \%+C%.%#[]%.%#,
        \%+C[]%.%#,
        \%+C%.%#%[{}\\]%.%#,
        \%+C<%.%#>%.%#,
        \%C\ \ %m,
        \%-GSee\ the\ LaTeX%m,
        \%-GType\ \ H\ <return>%m,
        \%-G\ ...%.%#,
        \%-G%.%#\ (C)\ %.%#,
        \%-G(see\ the\ transcript%.%#),
        \%-G\\s%#,
        \%+O(%f)%r,
        \%+P(%f%r,
        \%+P\ %\\=(%f%r,
        \%+P%*[^()](%f%r,
        \%+P[%\\d%[^()]%#(%f%r,
        \%+Q)%r,
        \%+Q%*[^()])%r,
        \%+Q[%\\d%*[^()])%r
