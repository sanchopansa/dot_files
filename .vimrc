let mapleader=","

" indentation properties
set tabstop=4
set shiftwidth=4
set softtabstop=4
set tw=80
set expandtab
set cindent
set smartindent
set autoindent

" search properties
set incsearch
set ignorecase
set smartcase

" color scheme properties
" let g:solarized_termcolors=256
set t_Co=16
set background=light
colorscheme solarized

" wildcards
set wildmode=longest,list
set wildignore=*.o,*.pyc,*.so,*.swp
set wildignore+=*/.git/*,*/.svn/*,*/.hg/*

" layout
set scrolloff=2
set showmode
set showcmd
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%))
set previewheight=6  " small preview window for docstrings, etc.
set laststatus=2     " use 2 lines for the status bar
set relativenumber   " relative numbers !!! wow
set nowrap           " disable ugly wrapping
set showmatch        " show matching brackets

" system settings
set virtualedit=block,onemore
set lazyredraw          " no redraws in macros (speeds things up)
set hidden              " remember undo after quitting
set history=50          " remember the last 50 commands

set pastetoggle=<F2> " helpful for pasting in insert mode

" Vundle specific
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" Below are plugins from GitHub repos
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-markdown.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'msanders/snipmate.vim.git'
Plugin 'tmhedberg/matchit.git'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
" Plugin 'majutsushi/tagbar.git'
" Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" look for matching braces {} not only at the start of the line
:map [[ ?{<CR>w99[{
:map ][ /}<CR>b99]}
:map ]] j0[[%/{<CR>
:map [] k$][%?}<CR>

function! SwitchToNextBuffer(incr)
  let help_buffer = (&filetype == 'help')
  let current = bufnr("%")
  let last = bufnr("$")
  let new = current + a:incr
  while 1
    if new != 0 && bufexists(new) && ((getbufvar(new, "&filetype") == 'help') == help_buffer)
      execute ":buffer ".new
      break
    else
      let new = new + a:incr
      if new < 1
        let new = last
      elseif new > last
        let new = 1
      endif
      if new == current
        break
      endif
    endif
  endwhile
endfunction

function! NumberToggle()
    if(&relativenumber == 1)
        call AbsNumber()
    else
        call RelNumber()
    endif
endfunc

function! RelNumber()
    set nonumber
    set relativenumber
endfunc

function! AbsNumber()
    set norelativenumber
    set number
endfunc

" shortcut mappings
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
nmap        <silent>   <Leader>ev           :arge $MYVIMRC<cr>
nmap        <silent>   <Leader>sv           :so $MYVIMRC<cr>
nnoremap               <Leader><c-]>        <c-w><c-}>
inoremap               <Leader><tab>        <c-x><c-p>
inoremap               <c-l>                <c-o>l
inoremap               <c-k>                <c-o>k
inoremap               <c-j>                <c-o>j
inoremap               <c-h>                <c-o>h
nnoremap     <silent>  <Leader>.            :call SwitchToNextBuffer(1)<CR> 
nnoremap     <silent>  <Leader>m            :call SwitchToNextBuffer(-1)<CR>
nnoremap               <Leader>b            :ls!<CR>:buffer<space>
inoremap               jj                   <esc>
nnoremap               <Leader>n            :call NumberToggle()<CR>
nnoremap               <Leader>ff           :CtrlPMixed<CR>
nnoremap               <Leader>f            :CtrlP<CR>

autocmd InsertEnter * call AbsNumber()
autocmd InsertLeave * call RelNumber()
" automatically close the popup menu / preview window      
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif      


" NERDTree specifics
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CtrlP specifics
let g:ctrlp_working_path_mode = 'rc'

" " TagBar specifics
" nnoremap <silent> <F9> :TagbarToggle<CR>
" let g:tagbar_autofocus = 1
