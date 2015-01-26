syntax on      	        "open syntax highlight
set fdm=syntax          "set fold method to syntax

if has("gui_running")
    set guioptions-=r
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set lines=36
    set columns=108
    set imdisable
    autocmd! InsertLeave * set imdisable|set iminsert=0
    autocmd! InsertEnter * set noimdisable|set iminsert=0
    if has("win32")
        behave mswin
        set guifont=Source_Code_Pro_Light:h13:cANSI
        "set fileencoding=chinese
        "set linespace=-1
    else
        set fileencoding=utf-8
        set guifont=Sauce\ Code\ Powerline\ Light:h16
        " set guifontwide=YaHei\ Mono:h14
        cd ~
    endif
endif

set encoding=utf-8
set fileencodings=utf-8,chinese,utf-16,latin1
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8

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
  let temp = @/
  %s/\s\+$//ge
  nohl
  let @/ = temp
  exe "normal `z"
  w
endfunc

command! -nargs=0 CleanTrailing call s:DeleteTrailingWS()
map <silent> <leader>dd :CleanTrailing<cr>

map <C-Tab> :bn<cr>

" add a function to help doing replace
function! DoReplace()
    let cmd = '%s/' . expand("<cword>") . '/'
    return cmd
endfunction
map * :<C-\>eDoReplace()<cr>
map # gd''
vmap / y/<C-R>"<CR>

map ft :call Search_Word()<CR>:copen<CR>
function! Search_Word()
    let w = expand("<cword>") " 在当前光标位置抓词
    execute "vimgrep " . w . " **"
endfunction

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
autocmd BufReadPost * execute "if g:fixPath == 0 | cd ".substitute(expand("%:p:h"), " ", "\\\\ ", "g")." |else | cd ".g:FixedPath." | endif"

" 插入匹配括号
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

noremap <silent> \|  :vsplit<CR>
noremap <silent> -   :split<CR>
noremap <silent> <C-z>   :close<CR>
noremap <silent> <Delete>   :bd<CR>
noremap <silent> <Left>     :bp<CR>
noremap <silent> <Right>    :bn<CR>

command! -nargs=* -complete=help Help vertical belowright help <args>

if has("mac")
    nmap <silent> <leader>t :po<cr>
endif

if has("cscope")
    execute "set cscopeprg=".&csprg
    set csto=0
    set cst
    nmap <leader>cs :cs find s expand("<cword>")<CR>
    nmap <leader>cc :cs find c expand("<cword>")<CR>
    nmap <leader>cd :cs find d expand("<cword>")<CR>
endif

function! s:MakeCTags()
    let l = split(glob("**/*.[h|c|]"))
    let l += split(glob("**/*.[h|c]pp"))
    let l += split(glob("**/*.cc"))
    call writefile(l, "src.files")
    call system(g:tagbar_ctags_bin." -R –c++-kinds=+px –fields=+iaS –extra=+q -L src.files")
    call system(&cscopeprg." -R -b -i src.files")
    set tags=tags
    cs add cscope.out
endfunction

command! -nargs=0 MakeCTags call s:MakeCTags()

function! s:MakeTags()
    call system(g:ctags_prog." -R .")
    set tags=tags
endfunction

command! -nargs=0 MakeTags call s:MakeTags()

let g:fixPath = 0
let g:FixedPath = ""
function! g:FixPath()
    if g:fixPath == 0
        let g:fixPath = 1
        let g:FixedPath = getcwd()
        if filewritable("tags")
            set tags=tags
        endif
        if filewritable("cscope.out")
            cs kill cscope.out
            cs add cscope.out
        endif
    else
        let g:fixPath = 0
        let g:FixedPath = ""
    endif
endfunction

command! -nargs=0 FixPath call g:FixPath()

