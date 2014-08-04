syntax on      	        "open syntax highlight
set fdm=syntax          "set fold method to syntax
if has("win32")
    behave mswin
    set guifont=Source_Code_Pro_Light:h13:cANSI
    "set fileencoding=chinese
    "set linespace=-1
    autocmd! InsertLeave * set imdisable
    autocmd! InsertEnter * set noimdisable
else
    set fileencoding=utf-8
    set guifont=YaHei\ Mono\ 10
    set guifontwide=YaHei\ Mono\ 10
    cd ~
endif

set encoding=utf-8
set fileencodings=utf-8,chinese,utf-16,latin1
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8

if has("gui_running")
    set guioptions-=r
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set lines=36
    set columns=108
endif

filetype indent on
filetype plugin on

set autoread                   " Set to auto read when a file is changed from the outside
set nobackup                   " no backup
set nowritebackup              " no write backup
set nu                         " display line number
set showtabline=0              " don't show tabbar
set imcmdline
set noswapfile                 " no swap file
set history=200                " Sets how many lines of history VIM has to remember
set ruler                      " show mouse position always
set backspace=eol,start,indent " Set backspace
set incsearch                  " include search
set hlsearch                   " highlight search things
set magic                      " set magic on, keep it 'on', you can use special characters in search patterns
set timeout!                   " remove boring key combine delay
set wrap                       " wrap line

set noerrorbells               " no sound on errors.
set novisualbell               " no visual bells
set vb t_vb=                   " close bell
set nofen                      " fold enable
set shiftwidth=4               " numbers of spaces to use for each step of indent
set tabstop=4
set smarttab                   " when on, a <tab> in front of a line inserts blanks accoring to 'shiftwidth'
set expandtab                  " use speces to insert a <tab>, and use ctrl-<tabl> to insert a real tab

"Fast Window Move Cofing
nmap <C-j> :wincmd j<cr>
nmap <C-k> :wincmd k<cr>
nmap <C-h> :wincmd h<cr>
nmap <C-l> :wincmd l<cr>

vnoremap <C-X>  "+x
vnoremap <C-C>  "+y
noremap  <C-S>  :update<CR>
vnoremap <C-S>    <C-C>:update<CR>
inoremap <C-S>    <C-O>:update<CR>
noremap  <C-V>  "+gP
imap     <C-V>  <C-R>+

"Fast remove highlight search
nmap <silent> <leader><cr> :noh<cr>

"delete all blanks at the tail of a line
func! s:DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  nohl
  exe "normal `z"
endfunc
nmap <silent> <leader>ds :call s:DeleteTrailingWS()<cr>:w<cr>

map <C-Tab> :bn<cr>

" add a function to help doing replace
function! DoReplace()
    let cmd = '%s/' . expand("<cword>") . '/'
    return cmd
endfunction
map * :<C-\>eDoReplace()<cr>
map # gd''
vmap / y/<C-R>"<CR>

let s:hexModle = 0
function! s:ToHexModle()
  if s:hexModle == 1
    %!xxd -r
    let s:hexModle = 0
  else
    %!xxd
    let s:hexModle = 1
  endif
endfunction

command! -nargs=0 ToHex call s:ToHexModle()
map <silent> <leader>h :ToHex<cr>

autocmd BufNewFile,BufRead *SCons* set filetype=python
autocmd BufNewFile,BufRead *scons* set filetype=python

" 插入匹配括号
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" noremap <silent> |   :vsplit<CR>
noremap <silent> -   :split<CR>
noremap <silent> <Delete>   :bd<CR>
noremap <silent> <Left>     :bp<CR>
noremap <silent> <Right>    :bn<CR>
noremap <F3> :%s/ \+$//<CR>

command! -nargs=* -complete=help Help vertical belowright help <args>

