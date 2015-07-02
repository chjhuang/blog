" Change to insert mode File: .vimrc
" Author: Jake Zimmerman <jake@zimmerman.io>
"
" How I configure Vim :P
"
" Gotta be first
set nocompatible

filetype off

" ---------------Vim plugins manager: Vim plug ------------------------
call plug#begin('~/.vim/plugged')

" ---- Auto Completion during typing -----
" Plug 'neocomplcache'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --omnisharp-completer' }     " Auto completion engine for many languages such as C

" ----- Making Vim look good ----
Plug 'altercation/vim-colors-solarized'     " Vim appearance color
"Plug 'tomasr/molokai'     " Molokai Color Scheme for Vim
Plug 'bling/vim-airline'     " Status bars and tabs

" ----- Vim as a programmer's text editor -----
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }   " File explorer NERDTree
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }  " Make all tabs share the same NERDTree
Plug 'scrooloose/nerdcommenter'   " Code comments help tool
" Syntax checker for lots of languages, eg. C,
" Java, Html, Tex, Python ...
Plug 'scrooloose/syntastic'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'   " , { 'on': 'TagbarToggle' }   ClassViewTag
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/a.vim'

" ----- Working with Git -----
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterToggle' }
Plug 'tpope/vim-fugitive', { 'on': 'GitGutterToggle' }

" ----- Other text editing features -----
Plug 'Raimondi/delimitMate'     " Autocompletion single or double quotes

" ----- man pages, tmux ----
"Plug 'jez/vim-superman'
"Plug 'christoomey/vim-tmux-navigator'

" ----- Syntax plugins ----
"Plug 'jez/vim-c0'
"Plug 'jez/vim-ispc'
"Plug 'kchmck/vim-coffee-script'
" --- XML -------
Plug 'othree/xml.vim', { 'for': 'xml' }  " On-demand loading
Plug 'docunext/closetag.vim', { 'for': 'xml' }  " Close open tags
" --- JS HTML CSS -----
Plug 'maksimr/vim-jsbeautify', { 'for': ['js', 'css', 'html'] }
Plug 'einars/js-beautify', { 'for': ['js', 'css', 'html'] }
" --- Markdown -----
Plug 'suan/vim-instant-markdown'   " Markdown instant previewer 

" ---- Extras/Advanced plugins ----
"Plug 'ntpeters/vim-better-whitespace'     " Highlight and strip trailing whitespace
"Plug 'tpope/vim-surround'      " Easily surround chunks of text
"Plug 'godlygeek/tabular'      " Align CSV files at commas, align Markdown tables, and more
"Plug 'HTML-AutoCloseTag'      " Automaticall insert the closing HTML tag
"Plug 'edkolev/tmuxline.vim'      " Make tmux look like vim-airline (read README for extra instructions)
"Plug 'ekalinin/Dockerfile.vim'
"Plug 'digitaltoad/vim-jade'
"Plug 'tpope/vim-liquid'
"Plug 'cakebaker/scss-syntax.vim'
call plug#end()

filetype plugin indent on


" ----------- General settings ---------------------------------------
set backspace=indent,eol,start   " Fix broken backspace in some steups
set ruler      " show where you are
set number     " show line numbers
set showcmd
set incsearch    " search as you type
set hlsearch
set autoindent
set autoread      " reload files when changed on disk
set clipboard=unnamed     " yank and paste with the system clipboard
set encoding=utf-8
set expandtab       " expand tabs to spaces
set scrolloff=1      " show context above/below cursorline
set shiftwidth=4     " normal mode indentation commands use 4 spaces
set softtabstop=4    " insert mode tab and backspace use 4 spaces
set tabstop=4        " actual tabs occupy 4 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu         " show a navigable menu for tab completion
set wildmode=longest,list,full
set mouse=a       " Enable basic mouse behavior such as resizing buffers.
set completeopt=longest,menu
set et    " Set all tab as Whitespaces
syntax enable     " syntax highlight
syntax on

autocmd BufWritePost ~/.vimrc so ~/.vimrc    " Reload .vimrc after .vimrc changed


" ------------ Keyboard Shortcuts Setting -------------------------------
let mapleader = ','   " Set <leader> as ,
let g:mapleader = ','
" -- n, i, v, c Mode -----
map <C-h> <C-w>h   " move to left vim windows
map <C-j> <C-w>j   " move to down vim windows
map <C-k> <C-w>k   " move to up vim windows
map <C-l> <C-w>l   " move to right vim windows
map <leader>l :Align
" -- Normal mode -----
nmap <leader>a :Ack
nmap <Tab> <C-w>w   " move to next vim windows
" --Insert mode -----
imap <C-c> <Esc> yy   " Copy
imap <C-v> <Esc> p    " Paste
imap <A-v> <Esc> v    " Change to visual mode
imap <A-c> <Esc> :    " Change to command mode
" -- Visual mode ----
vmap i <Esc> i        " Change to insert mode


" ------------ Plugin-Specific Settings ----------------------------------

" ----- neocomplcache (advanced completion) settings ------
"let g:acp_enableAtStartup = 0
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_dictionary_filetype_lists = {
"      \ 'default' : '',
"      \ 'vimshell' : $HOME.'/.vimshell_hist',
"      \ 'scheme' : $HOME.'.ghosh_completions'
"      \ }
"inoremap <expr><C-g> neocomplcache#undo_completion()
"inoremap <expr><C-l> neocomplcache#complete_common_string()
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"    return neocomplcache#smart_close_popup() . "\<CR>"
"endfunction
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"function! SetToCabalBuild()
"    if glob("*.cabal") != ''
"        set makeprg=cabal\ build
"    endif
"endfunction
"autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()

" ----- Valloric/YouCompleteMe settings -----
let g:ycm_min_num_of_chars_for_completion = 3  " controls the number of characters before identifier-based completion suggestions are triggered
let g:ycm_error_symbol = '✘'
let g:ycm_warning_symbol = '⚠'
let g:ycm_complete_in_comments = 1  " show completion menu even when typing inside comments
"let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'     " Set default global config
"let g:ycm_confirm_extra_conf=0      " Avoid confirm each load
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoTo<CR>  " Go to declaration else defination
nnoremap <leader>gk :YcmCompleter GoToImprecise<CR>   " Quick goto without recompile
nnoremap <leader>gt :YcmCompleter GetType<CR>    " Echos the type of the variable or method
nmap <F4> :YcmDiags<CR>
" Set Autocompletion for other languages
augroup myYCM
  au!
  au FileType css set omnifunc=csscomplete#CompleteCSS
  au FileType html set omnifunc=htmlcomplete#CompleteTags
augroup END


" ----- altercation/vim-colors-solarized settings -----
set background=dark    " Toggle this to "light" for light colorscheme
"let g:solarized_termcolors=256  " Uncomment the next line if your terminal is not configured for solarized

" Set the colorscheme
try
    colorscheme solarized
catch
endtry


" ----- bling/vim-airline settings -----
set laststatus=2    " Always show statusbar
let g:airline_detect_paste=1   " Show PASTE if in paste mode

" Airline style setting
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'

" Show airline for tabs too
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#buffline#enabled = 1
"let g:airline#extensions#bufferline#overwrite_variables = 1

" Theme setting
let g:airline_theme = 'powerlineish'
set t_Co=256


" ----- jistr/vim-nerdtree-tabs settings -----
" Open/close NERDTree Tabs with ,nt
nnoremap <leader>nt :NERDTreeTabsToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
"let g:nerdtree_tabs_open_on_console_startup = 0   " To have NERDTree always open on startup


" ----- scrooloose/syntastic settings -----
let g:syntastic_auto_jump = 3   " Make the cursor jump to the first detected error
let g:syntastic_auto_loc_list = 1   " Open location list automatically when errors are detected
let g:syntastic_loc_list_height = 5   " Specify the height of the location lists
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '⚠'

" Show location list and display the error messages
nnoremap <leader>se :Errors<CR>
" Manually cause a syntax check to be done.
nnoremap <leader>sc :SyntasticCheck<CR>
" Get the info about the checker available for current filetype
nnoremap <leader>si :SyntasticInfo<CR>

augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END


" ----- xolox/vim-easytags settings -----
set tags=./tags;,~/.vimtags    " Where to look for tags files
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \t
nnoremap <leader>tt :TagbarToggle<CR> 
let g:tagbar_width = 23  " Set tagbar windows width
let g:tagbar_indent = 1  " SubItems' indent
let g:tagbar_expand = 1  " Expand Vim by the width of tagbar width
"autocmd BufEnter * nested :call tagbar#autoopen(0)  " auto showed whenever new file open

" ----- airblade/vim-gitgutter settings -----
" Open/close gitgutter with ,gt
nnoremap <leader>gt :GitGutterToggle<CR>
hi clear SignColumn    " Required after having changed the colorscheme 
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1 

" ----- einars/js-beautifer settings ----
augroup myJsBeautifer
  au!
  au FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
  au FileType html noremap <buffer> <c-f> :call JsBeautify()<cr>
  au FileType css noremap <buffer> <c-f> :call JsBeautify()<cr>
augroup END

" ------ suan/vim-instant-markdown
let g:instant_markdown_slow = 1  " Make markdown previewer only refresh on the event that no keys have been pressed for a while
let g:instant_markdown_autostart = 0  " Manually trigger preview by command
nnoremap <leader>mp :InstantMarkdownPreview<CR>

" ---- docunext/closetag.vim settings -------

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END
