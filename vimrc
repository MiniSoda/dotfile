" 定义快捷键的前缀，即<Leader>
let mapleader=";"

let g:clangd_path = '/tools/compilers/x86_64/clang+llvm/latest/clangd'
let g:compile_commands_dir = '/mnt/home/barco.com/jiazhe/sandbox/pt-platinum/build/samba/target/'
let g:query_driver = '/tools/buildroot/pt_ducky_c16baef/arm-buildroot-linux-gnueabihf_sdk-buildroot/bin/arm-buildroot-linux-gnueabihf-g++'


" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至左方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
" 定义快捷键在结对符之间跳转
nmap <Leader>M %

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
function! ToggleFullscreen()
  call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endfunction
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
" 启动 vim 时自动全屏
autocmd VimEnter * call ToggleFullscreen()

" 保存 undo 历史
set undodir=~/.undo_history/
set undofile

" vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'preservim/nerdtree'
Plugin 'vim-scripts/DrawIt'
Plugin 'SirVer/ultisnips'
Plugin 'derekwyatt/vim-protodef'
Plugin 'gcmt/wildfire.vim'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'suan/vim-instant-markdown'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'

Plugin 'liuchengxu/vista.vim'
" Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
" Plugin 'octol/vim-cpp-enhanced-highlight'

" 插件列表结束
call vundle#end()
filetype plugin indent on

" 配色方案
"set background=dark
"colorscheme solarized
colorscheme molokai
"colorscheme phd
"colorscheme lightning 

" 禁止光标闪烁
set gcr=a:block-blinkon0

" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

set term=xterm-256color
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
set termguicolors

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch

" airline config
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:bufferline_show_bufnr = 0

" 使用obsession
 let g:airline#extensions#obsession#enabled = 1
 " set marked window indicator string
 let g:airline#extensions#obsession#indicator_text = '$'

map <leader>ss :Obsess ~/.vim/bundle/vim-obsession/session<cr>
map <leader>ls :source ~/.vim/bundle/vim-obsession/session<cr>

" mapping tab hotkey
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
map <Leader>x  :bp\|:bdelete #<CR>
map <Leader>X  :bp\|:bdelete! #<CR>


" 设置 gvim 显示字体
" set guifont= Consolas
" set guifont=Powerline\ Consolas\ 12
" font repository https://github.com/Znuff/consolas-powerline
"set guifont=Consolas\ NF\ 13
 set guifont=YaHei\ Consolas\ Hybrid\ 12
" set guifont=Go\ Mono\ for\ Powerline\ 12

" 禁止折行
set nowrap

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

syntax keyword cppSTLtype initializer_list

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=2
" 设置格式化时制表符占用空格数
set shiftwidth=2
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=2


" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle


" 基于缩进或语法进行代码折叠
set foldmethod=indent
"set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" *.cpp 和 *.h 间切换
nmap <silent> <Leader>sw :FSHere<cr>


" :echo has('signs')
"
" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>
" 取消修改buffer后默认阻止切换buffer的行为
:set hidden


let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }


" Configure for vim-lsp
" disable diagnostics support
" let g:lsp_diagnostics_enabled = 1         
let g:lsp_semantic_enabled = 1

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': g:clangd_path,
        \ 'cmd': {server_info->['clangd', '-pretty', '-background-index', '--log=verbose', '--header-insertion=never',
        \ '--compile-commands-dir=' . g:compile_commands_dir,
        \ '--query-driver=' . g:query_driver]},
        \ 'whitelist': ['c', 'cpp', 'h', 'hpp', 'hxx'],
        \ })
endif


nnoremap <leader>gd :LspDefinition<CR>
nnoremap <leader>jd :LspDeclaration<CR>
nnoremap <leader>fr :LspReferences<CR>
nnoremap <leader>js :LspStatus<CR>
nnoremap <leader>pd :LspPeekDefinition<CR>

" Setup asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" au User asyncomplete_setup call asyncomplete#register_source({
" \ 'name': 'vim-lsp',
" \ 'whitelist': ['c', 'cpp', 'python', 'javascript', 'html', 'css'],
" \ 'completor': function('asyncomplete#sources#vim_lsp#completor'),
" \ })


" vista 
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

nnoremap <leader>il :Vista!!<CR>
" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'vim-lsp'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['left:50%']
let g:vista_sidebar_position = 'vertical topleft'


" nerdtree
fun! GetCurrentRoot()
  let t:root = g:NERDTree.ForCurrentTab().getRoot().path.str()
endfun

" file locate
nmap <leader>f :NERDTreeFind<cr>

" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=31
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" 当没有buff时关闭NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif