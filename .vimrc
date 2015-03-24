" neil killeen

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                preamble                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set shell=/bin/bash\ --rcfile\ ~/.bash_profile
"let $PATH=system('echo $PATH')
let $PATH.=':/usr/local/bin'

" Needed for vundle, will be turned on after vundle inits
set nocompatible
filetype off

" Setup vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Vundle configuration                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" These need to come before the configuration options for the plugins since
" vundle will add the plugin folders to the runtimepath only after it has seen
" the plugin's Plugin command.

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'bling/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'altercation/vim-colors-solarized'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           reset vimrc augroup                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  autocmd!
  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  " Source the vimrc file after saving it
  autocmd bufwritepost vimrc source $MYVIMRC
  " Stop that dumb autocommenting
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        turn on filetype plugins                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable detection, plugins and indenting in one step
" This needs to come AFTER the Plugin commands!
filetype plugin indent on
syntax on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            General settings                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DISPLAY SETTINGS
set background=dark
set scrolloff=7         " 2 lines above/below cursor when scrolling
set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set undofile            " stores undo state even when files are closed (in undodir)
set cursorline          " highlights the current line
set winaltkeys=no       " turns of the Alt key bindings to the gui menu
set number              " show line numbers
set relativenumber      " show line numbers relative to current line
set guifont=PragmataPro:h14

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu

" This changes the default display of tab and CR chars in list mode
set listchars=tab:▸\ ,eol:¬

" The "longest" option makes completion insert the longest prefix of all
" the possible matches; see :h completeopt
set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab

" EDITOR SETTINGS
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
"set smartindent         " smart auto indenting
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup            " no backup~ files.

set tabstop=2           " number of spaces a tab counts for
set shiftwidth=2        " spaces for autoindents
set softtabstop=2
set shiftround          " makes indenting a multiple of shiftwidth
set expandtab           " turn a tab into spaces
set laststatus=2        " the statusline is now always shown
set noshowmode          " don't show the mode ("-- INSERT --") at the bottom

" misc settings
set fileformat=unix     " file mode is unix
set fileformats=unix,dos,mac   " detects unix, dos, mac file formats in that order

set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo
                        " file -- 20 jump links, regs up to 500 lines'
set hidden              " allows making buffers hidden even with unsaved changes
set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo
set autoread            " auto read when a file is changed from the outside
set mouse=a             " enables the mouse in all modes
set foldlevelstart=99   " all folds open by default
set noesckeys           " after esc is hit don't wait for modifier (arrow keys don't work in insert mode)
set ttimeoutlen=100     " timeout for a keycode delay (speeds up esc + shift + o)

" toggles vim's paste mode; when we want to paste something into vim from a
" different application, turning on paste mode prevents the insertion of extra
" whitespace
set pastetoggle=<F7>

" Right-click on selection should bring up a menu
set mousemodel=popup_setpos

" With this, the gui (gvim and macvim) now doesn't have the toolbar, the left
" and right scrollbars and the menu.
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=M

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix = 1

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess=a

" this solves the "unable to open swap file" errors on Win7
set dir=~/tmp,/var/tmp,/tmp,$TEMP
set undodir=~/tmp,/var/tmp,/tmp,$TEMP

" Look for tag def in a "tags" file in the dir of the current file, then for
" that same file in every folder above the folder of the current file, until the
" root.
set tags=libraries/tags;tags;/
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <c-tab> :tabn<CR>

" turns off all error bells, visual or otherwise
set noerrorbells visualbell t_vb=
autocmd vimrc GUIEnter * set visualbell t_vb=

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax enable
endif

" none of these should be word dividers, so make them not be
set iskeyword+=_,$,@,%,#

" Number of screen lines to use for the command-line
set cmdheight=2

" allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,h,l
set nohlsearch          " do not highlight searched-for phrases
set incsearch           " ...but do highlight-as-I-type the search string
set gdefault            " this makes search/replace global by default

" enforces a specified line-length and auto inserts hard line breaks when we
" reach the limit; in Normal mode, you can reformat the current paragraph with
" gqap.
set textwidth=80

" this makes the color after the textwidth column highlighted
set colorcolumn=+1

" options for formatting text; see :h formatoptions
set formatoptions=tcroqnj
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            custom mappings                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       ***  HERE BE PLUGINS  ***                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Solarized                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:solarized_visibility="high"
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_termtrans=1
let g:solarized_hitrail=1
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            vim-indent-guides                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_color_change_percent = 7
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              YouCompleteMe                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1}

nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>pg :YcmCompleter GoTo<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                tagbar                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

nnoremap <F4> :TagbarToggle<cr><c-w>=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                ack.vim                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('ag')
  let g:agprg = "ag --nocolor --nogroup --column"
endif
if executable('ack')
  let g:ackprg = "ack --nocolor --nogroup --column"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                go-vim                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au vimrc FileType go nmap <Leader>gs <Plug>(go-implements)
au vimrc FileType go nmap <Leader>gi <Plug>(go-info)
au vimrc FileType go nmap <Leader>gd <Plug>(go-doc) 
au vimrc FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au vimrc FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au vimrc FileType go nmap <leader>gr <Plug>(go-run)
au vimrc FileType go nmap <leader>gb <Plug>(go-build)
au vimrc FileType go nmap <leader>gt <Plug>(go-test)
au vimrc FileType go nmap <leader>gc <Plug>(go-coverage)
au vimrc FileType go nmap <leader>gd <Plug>(go-def)
au vimrc FileType go nmap <Leader>ds <Plug>(go-def-split)
au vimrc FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au vimrc FileType go nmap <Leader>dt <Plug>(go-def-tab)
au vimrc FileType go nmap <Leader>ge <Plug>(go-rename)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                UltiSnips                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" we can't use <tab> as our snippet key since we use that with YouCompleteMe
let g:UltiSnipsExpandTrigger       = "<c-d>"
let g:UltiSnipsJumpForwardTrigger  = "<c-s>"
let g:UltiSnipsJumpBackwardTrigger = "<c-a>"
let g:snips_author                 = 'Neil Killeen'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Eclim                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EclimCompletionMethod = 'omnifunc'
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             NumberToggle                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NumberToggleTrigger="<F2>"

" Control P
let g:ctrlp_working_path_mode = 'ra'

" Visual effects
set lazyredraw
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
