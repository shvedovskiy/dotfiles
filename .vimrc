set nocompatible            
filetype off              

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Rip-Rip/clang_complete'
Plugin 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()          
filetype plugin indent on   

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

set shell=/bin/bash
runtime macros/matchit.vim

let $PATH='/usr/local/bin:' . $PATH

set relativenumber
set bs=indent,eol,start
set visualbell
set smartindent
set ttyfast
set lazyredraw
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=500
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set showmatch	  " Show matching brackets.
set incsearch     " do incremental searching
set hlsearch      " Подсвечивать поиск
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set is            " Использовать инкреминтированный поиск
set lines=25
set columns=150
set smartcase
set ignorecase
set noantialias
set list listchars=tab:>-,trail:.,extends:>,precedes:<
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
set laststatus=2   " всегда показывать строку статуса

set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" Syntax highlighting enables.
if has("syntax")
  syntax on
endif

" Highlight line number of where cursor currently is
hi CursorLineNr guifg=#050505

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Sessions
let g:session_autoload = 'no'

" Leave paste mode on exit
au InsertLeave * set nopaste

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Leader Mappings
map <Space> <leader>
map <Leader>w :update<CR>
map <Leader>q :qall<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gp :Gpush<CR>

" Command aliases
cabbrev tp tabprev
cabbrev tn tabnext
cabbrev tf tabfirst
cabbrev tl tablast

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" bind K to search word under cursor
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

" Airline
"let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
set t_Co=256

" Color scheme
let g:solarized_termcolors=256
syntax enable
colorscheme solarized
set background=dark
set encoding=utf-8

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

set langmap=!\\"№\\;%?*ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;!@#$%&*`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" Включаем bash-подобное дополнение командной строки
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Easy navigation between splits. Instead of ctrl-w + j. Just ctrl-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Автоматическое закрытие скобок
imap [ []<LEFT>
imap ( ()<LEFT>
imap { {}<LEFT>

" Позволим конфигурационным файлам в проекте изменять настройки vim'a
set exrc
set secure

" Numbers
set number
set numberwidth=5

map <C-c> y<CR> "позволяет копировать текст нажатием Ctrl+c
map <C-v> p "позволяет вставлять текст нажатием Ctrl+v
imap <C-v> <ESC>pi "тоже вставка текста, только в режиме редактирования
vmap <C-c> y<CR> "копирование текста, только в визуальном режиме

function! ToggleCPPHeader()
    let current=expand("%")
    let header=substitute(current, "\.cpp$", ".h", "")
    if header==current
        let header=substitute(current, "\.h$", ".cpp", "")
    endif
    if filereadable(header)
        exec "edit " . header
    endif
endfunction

map <C-H>  :call ToggleCPPHeader()<CR>
noremap <F3> :call Svndiff("prev")<CR> 
noremap <F4> :call Svndiff("next")<CR> 
noremap <F5> :call Svndiff("clear")<CR>
nmap <CR> _A<Enter><Esc>
nmap <Space> i<Space><ESC>

let c_space_errors = 1

highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen

autocmd vimenter * NERDTree
nnoremap <leader>nt :NERDTreeToggle<CR>

let g:Powerline_symbols = 'fancy'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Clang-completer                                                                
" Включить дополнительные подсказки (аргументы функций, шаблонов и т.д.)        
let g:clang_snippets=1                                                          
" Использоать ultisnips для дополнительных подсказок (чтобы подсказки шаблонов  
" автогенерации были в выпадающих меню)                                         
let g:clang_snippets_engine = 'ultisnips'                                      
" Периодически проверять проект на ошибки                                       
let g:clang_periodic_quickfix=1                                                 
" Подсвечивать ошибки                                                           
let g:clang_hl_errors=1
" Автоматически закрывать окно подсказок после выбора подсказки                 
let g:clang_close_preview=1                                              
" По нажатию Ctrl+F проверить поект на ошибки                                   
map <c-f> :call g:ClangUpdateQuickFix()<cr>

" Расставлять отступы в стиле С
autocmd filetype c,cpp set cin 

" autocomplete C
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

