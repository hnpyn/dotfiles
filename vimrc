" __  ____   ____     _____ __  __ ____   ____
"|  \/  \ \ / /\ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  \ \ / / | || |\/| | |_) | |
"| |  | | | |    \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|     \_/  |___|_|  |_|_| \_\\____|

" Author:@hnpyn

" I have transfered to neovim, just keep basic settings

" -------------------------------------------------------
" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" User Settings
set nocompatible    " 设置不与vi兼容
set ic              " 搜索时忽略大小写
set hlsearch        " 高亮显示搜索结果
set incsearch       " 增量式搜素
set scrolloff=2     " 光标上下至少显示的行数
set number          " 左侧显示行号
set relativenumber  " 相对行号
set hidden          " 允许在有未保存的修改时替换缓冲区，vim保存修改
set expandtab       " tab 替换为空格
set tabstop=4       " tab 长度为4个空格
set encoding=utf-8  " 编码为utf-8
set fileencodings=utf-8,usc-bom,GB2312,big5  " 逐一探测编码方式
set nobackup        " 覆盖文件时不备份
set nowritebackup   " 不备份
set cursorline      " 突出显示当前行
set ruler           " 在右下角显示光标位置的状态行
set autoindent      " 自动缩进
set smartindent     " 智能缩进
set shiftwidth=4    " 缩进时，缩进的空格数
set showmatch       " 输入括号时，光标短暂的跳到匹配括号处
set autoread        " 文件发生变化时，自动读取新文件
set go=             " 取消图形按钮
set signcolumn=yes  " 显示侧边栏
set backspace=indent,eol,start  " 设置退格

" 自定义控制键
let mapleader=' '

" , w直接保存
ino ,w <Esc>:w<cr>
" map jj to escape key
ino jj <Esc>
" 分屏中的光标移动
nor <C-h> <C-w>h
nor <C-j> <C-w>j
nor <C-k> <C-w>k
nor <C-l> <C-w>l
" 分屏
nor <leader>s <C-w>s
nor <leader>v <C-w>v
nor <leader>q <C-w>q
" 不保存退出
nor <C-c><C-c> <Esc>:q!<cr>
" no highlight
map("n", "<Esc>", "<CMD>noh<CR>", opt)

filetype on

" call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes #确保使用单引号！！！

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }  " 目录树
" Plug 'mhinz/vim-startify'  " 开始界面
" Plug 'ghifarit53/tokyonight-vim'  " 主题
" Plug 'Yggdroot/indentLine'  " 缩进分割线
" Plug 'vim-airline/vim-airline'  " 底部栏
" Plug 'vim-airline/vim-airline-themes'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}  " coc自动补全
" Plug 'preservim/tagbar'  " 右侧显示文件结构
" 
" call plug#end()

" pretty dress
set termguicolors
" set highlight to 1000ms
let g:highlightedyank_highlight_duration = 1000
" set highlight color
hi Visual guifg=#0d0e0f guibg=#eebd35 gui=none
hi Search guifg=#0d0e0f guibg=#eebd35 gui=none
hi IncSearch guifg=#0d0e0f guibg=#eebd35 gui=none
" tokyonight主题设置
" let g:tokyonight_transparent_background = 1  " 和终端透明度保持一致
" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 1
" let g:Tlist_Ctags_Cmd='/opt/homebrew/Cellar/ctags/5.8_2/bin/ctags'
" 
" 颜色主题设置
set background=dark
colorscheme gruvbox

