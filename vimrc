" 这几行是vundle插件需要的配置,所以需要放在最前面
set nocompatible        "Get out of VI's compatible mode..
syntax on      	        "open syntax highlight
set fdm=syntax          "set fold method to syntax
filetype off

let mapleader = ","
let g:mapleader = ","

if has("win32")
    let s:vimRunPath = simplify($VIMRUNTIME."\\..\\vimfiles\\bundle")
else
    let s:vimRunPath = "~/.vim/bundle"
endif

" set the runtime path to include Vundle and initialize
exec "set rtp+=".s:vimRunPath."/neobundle.vim"
call neobundle#begin(s:vimRunPath)


" 下面列出所有需要加载的插件及其配置
NeoBundleFetch 'Shougo/neobundle.vim'



" 协助开发的一些配置,以方便编译调试运行c lua python等代码
NeoBundle 'jianshanbushishan/vim-dev-mate' "{{{
if has('win32') || has('win64')
    let g:console_app = "e:\\software\\console2\\Console.exe"
endif
"}}}



" 将一些通用的配置从vimrc中抽取出来放在了这里,方便修改
NeoBundle 'jianshanbushishan/vim-base'



if has("gui_running")
    " textmate下的配色方案
    NeoBundle 'tomasr/molokai'
    NeoBundle 'altercation/vim-colors-solarized'
" 颜色方案的设置需要放到vundle加载后,否则将不会生效
endif



" tagbar用于显示代码的outline显示,比如列出函数,宏等
NeoBundle 'majutsushi/tagbar' "{{{
nmap <silent> <F9> :TagbarToggle<cr>
let g:tagbar_ctags_bin = expand('$VIMRUNTIME').'\ctags.exe'
if has("win32")
    set csprg='cscope.exe'
else
    let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
    set csprg='/usr/local/bin/cscope'
endif
"}}}



" 一款应用firefox的Vimperator插件的快速移动思想的vim插件
" 将vim移动中的出现的所有可能的位置使用字母标出以便单键到达
" 可以考虑给其加上使用中文拼音快速定位中文的支持
NeoBundle 'Lokaltog/vim-easymotion' "{{{
" 默认的map是把<leader>映射为两个<leader>
" 另外默认的映射是<leader>+vim内置的移动键进行快速移动
" 比如,e ,w ,b ,j ,k ,f等
map <Leader> <Plug>(easymotion-prefix)
" 使用s搜索后可按tab或shift+tab来切换页面到合适的位置后按回车
" 再使用字母进行所有可到达位置的标记
map s <Plug>(easymotion-sn)
map f <Plug>(easymotion-bd-f)
map K <Plug>(easymotion-bd-jk)
"}}}



" fencview特别针对中文的编码进行自动检测,并将编码设置为正确的编码
" 它的准确率相对其它vim类似插件高很多
" 它用来于libconv.dll,需要将其放入系统PATH中
NeoBundle 'mbbill/fencview' "{{{
" 遇到乱码时手工使用:FencAutoDetect检测
" 开启这个选项会影响打开文件速度
let g:fencview_autodetect = 0
"}}}



" session管理插件,使用session后可以方便的保存和加载工作环境
" 常用命令:SessionOpen SessionSave SessionView SessionClose
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session' "{{{
"session settings
let g:session_autoload='no'
let g:session_autosave='yes'
let g:session_default_to_last=0
let g:session_command_aliases=1
"}}}



" 一个强大的彩色状态栏,可用于显示各种信息
" 另外会在顶部显示buffer列表,用起来比较方便
" 需要使用powerline的字体才会显示一些特殊字符
if has("gui_running")
    NeoBundle 'bling/vim-airline' "{{{
    let g:airline#extensions#tagbar#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_tab_type = 0
    let g:airline#extensions#tabline#fnamecollapse = 1
    let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#formatter = 'mine'
    set laststatus=2
endif
"}}}



" 代码注释插件, 支持的代码种类齐全, 将其开关绑定为空格后手感极好
NeoBundle 'tpope/vim-commentary' "{{{
nmap <SPACE> gcc
vmap <SPACE> gcc
"}}}



" 一款小插件,使用+扩展选择的内容,比如在双引号的字符串直接选中整个字符串等
NeoBundle 'terryma/vim-expand-region'



" 如果不考虑c++的智能补全,常用的补全使用这个插件足够
" windows下使用YouCompleteMe安装略麻烦
NeoBundle 'Shougo/neocomplete.vim' "{{{
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"}}}



" 仿照snipmate的插件,支持自定义代码模版,从而快速插入整段代码,并按顺序修改模版
" 整体功能较强大, 暂时有很多功能还用不到
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets' "{{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"}}}



" 快速搜索插件,支持搜索打开的buffer,目录下的所有文件,以及menu等各种数据
" 可以考虑自己使用qt写个类似插件,实现sublime中c-a-p那个框的效果
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'mac' : 'make',
\     'linux' : 'make',
\    },
\ }
NeoBundle 'Shougo/unite.vim' "{{{
let g:unite_source_history_yank_enable = 1
"}}}



" qt quick的qml脚本的配置插件,支持语法高亮,indent配置
NeoBundle 'peterhoeg/vim-qml'



" 一款支持使用中文拼音首字母搜索的插件
NeoBundle 'jianshanbushishan/vim-PYSearch' "{{{
map ? :PYSearch<CR>
map <A-n> :PYNext<CR>
"}}}



" 用来做各种编程语言的语法检查
NeoBundle 'scrooloose/syntastic' "{{{
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['ruby', 'lua'],
                           \ 'passive_filetypes': [] }
map <F2> :SyntasticCheck<CR>
map <C-F2> :SyntasticReset<CR>
"}}}


call neobundle#end()
filetype plugin indent on

if has("gui_running")
    colorscheme molokai
else
    colorscheme darkblue
endif

set background=dark
