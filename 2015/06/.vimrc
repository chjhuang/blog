" File: .vimrc
" Author: Jeff Chan
"
" Inherit from Jake Zimmerman: https://github.com/jez/vim-as-an-ide
"

" Gotta be first
set nocompatible

filetype off

" ---------------Vim plugins manager: Vim plug ------------------------
call plug#begin('~/.vim/plugged')

" ----- Auto Completion during typing -----
" Plug 'neocomplcache'

" A code-completion engine for Vim: 
" https://github.com/Valloric/YouCompleteMe
" Pre-Install: 
"  1. install development tools and cmake:
"      sudo apt-get install build-essential cmake
"  2. make sure you have python headers installed:
"      sudo apt-get install python-dev
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --omnisharp-completer' }

" Provides insert mode auto-completion for quotes, parens, brackets, etc
" https://github.com/Raimondi/delimitMate
Plug 'Raimondi/delimitMate'

" ----- Making Vim look good ----
" Precision colorscheme for the vim text editor
" https://github.com/altercation/vim-colors-solarized
Plug 'altercation/vim-colors-solarized'

"Plug 'tomasr/molokai'     " Molokai Color Scheme for Vim

" Lean & status/tabline for vim
" https://github.com/bling/vim-airline
Plug 'bling/vim-airline'

" ----- Vim as a programmer's text editor -----
" A tree explorer plugin for vim
" https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
" Make 'Just one NERDTree', independent of tabs
" https://github.com/jistr/vim-nerdtree-tabs
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }

" Vim plugin for intensely orgasmic commenting
" https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'

" Syntax checking hacks for vim
" https://github.com/scrooloose/syntastic
Plug 'scrooloose/syntastic'

" Miscellaneous auto-load Vim scripts
" https://github.com/xolox/vim-misc
" Here use for auto-loading vim-easytags
"Plug 'xolox/vim-misc'
" Automated tag file generation and syntax highlight of tags in Vim
" https://github.com/xolox/vim-easytags
" Pre-Install:
"  1. install ctags: sudo apt-get install exuberant-ctags
" Hint: I'm not sure whether it's need for tagbar, 
"       but it still worked when i commented it.
"Plug 'xolox/vim-easytags'

" Displays the tags of current file and get an overview
" of it's structure in a window, ordered by scope
" https://github.com/majutsushi/tagbar
" Pre-Install:
"  1. install ctags: sudo apt-get install ctags
Plug 'majutsushi/tagbar'  ", { 'on': 'TagbarToggle' }  hint: airline use it as a extension

" Fuzzy file, buffer, mru, tag, etc finder
" https://github.com/ctrlpvim/ctrlp.vim
" Active fork of https://github.com/kien/ctrlp.vim
"Plug 'kien/ctrlp.vim'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
" A ctrlp.vim extension - Navigate and jump to functions/classes defs
" https://github.com/tacahiroy/ctrlp-funky
" Pre-Install: ctrlp.vim
Plug 'tacahiroy/ctrlp-funky', { 'on': 'CtrlP'}

" Alternate Files quickly(switch between
" source files and header files quickly)
" https://github.com/vim-scripts/a.vim
"Plug 'vim-scripts/a.vim', { 'for': ['cpp', 'h'] }

" ----- Working with Git -----
" Shows a git diff in the gutter(sign column) and stages/reverts hunks
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterToggle' }
" A git wrapper so awesome
" https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive', { 'on': 'GitGutterToggle' }

" ----- man pages, tmux ----
"Plug 'jez/vim-superman'
"Plug 'christoomey/vim-tmux-navigator'

" ----- Syntax plugins ----
"Plug 'jez/vim-c0'
"Plug 'jez/vim-ispc'
"Plug 'kchmck/vim-coffee-script'

" --- XML -------
" Helps editing xml(and [x]html, sgml, xslt) files
" https://github.com/othree/xml.vim
Plug 'othree/xml.vim', { 'for': 'xml' }
" Functions and mappings to close open HTML/XML tags
" https://github.com/docunext/closetag.vim
Plug 'docunext/closetag.vim', { 'for': 'xml' }

" --- JS HTML CSS -----
" Allows you to use jsbeautifier inside vim to quickly
" format javascript, html and css files
" https://github.com/maksimr/vim-jsbeautify
" Pre-Install:
"   1. install a javascript interpreter: nodejs or v8
Plug 'maksimr/vim-jsbeautify', { 'for': ['js', 'css', 'html'] }
" Beautifier for javascript
" It seems not a vim plugin now
Plug 'einars/js-beautify', { 'for': ['js', 'css', 'html'] }
" Automatically closes HTML tags once you finish typing them.
" https://github.com/vim-scripts/HTML-AutoCloseTag
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }

" --- Markdown -----
" Instant markdown previews from vim
" https://github.com/suan/vim-instant-markdown
" Pre-Install:
"   1. sudo npm -g install instant-markdown-d
"   2. sudo apt-get install xdg-utils(is installed by default on Ubuntu)
Plug 'suan/vim-instant-markdown' 

" ---- Extras/Advanced plugins ----
"Plug 'ntpeters/vim-better-whitespace'     " Highlight and strip trailing whitespace
"Plug 'tpope/vim-surround'      " Easily surround chunks of text
"Plug 'godlygeek/tabular'      " Align CSV files at commas, align Markdown tables, and more
"Plug 'edkolev/tmuxline.vim'      " Make tmux look like vim-airline (read README for extra instructions)
"Plug 'ekalinin/Dockerfile.vim'
"Plug 'cakebaker/scss-syntax.vim'

" Run commands quickly
" https://github.com/thinca/vim-quickrun
"Plug 'thinca/vim-quickrun'

" Allows you to visually select increasingly larger regions
" of text using the same key combination
" https://github.com/terryma/vim-expand-region
Plug 'terryma/vim-expand-region'

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
let mapleader = "\<Space>"   " Set <leader> as ,
let g:mapleader = "\<Space>"
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


" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
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

let g:airline#extensions#whitespace#enabled = 0  " disable detection of whitespace errors

" Theme settings
let g:airline_theme = 'powerlineish'
set t_Co=256  " fix 'There are no colors' bug
set ttimeoutlen=50  " fix 'There is a pause when leaving insert mode' bug

" Commands Shortcuts
" Toggles whitespace detection
nnoremap <leader>tw :AirlineToggleWhitespace<CR>


" ----- jistr/vim-nerdtree-tabs settings -----
" Open/close NERDTree Tabs with ,nt
nnoremap <leader>nt :NERDTreeTabsToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
"let g:nerdtree_tabs_open_on_console_startup = 0   " To have NERDTree always open on startup


" ----- scrooloose/nerdcommenter settings ------
" Auto add extra spaces after the left delimiter
let g:NERDSpaceDelims=1


" ----- scrooloose/syntastic settings -----
let g:syntastic_auto_jump = 3   " Make the cursor jump to the first detected error
let g:syntastic_auto_loc_list = 1   " Open location list automatically when errors are detected
let g:syntastic_loc_list_height = 5   " Specify the height of the location lists
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '⚠'

" Select default checker
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_html_checker=['jshint']
let g:syntastic_css_checker=['csslint']

" Show location list and display the error messages
nnoremap <leader>se :Errors<CR>
" Manually cause a syntax check to be done.
nnoremap <leader>sc :SyntasticCheck<CR>
" Get the info about the checker available for current filetype
nnoremap <leader>si :SyntasticInfo<CR>

"augroup mySyntastic
"  au!
"  au FileType tex let b:syntastic_mode = "passive"
"augroup END


" ----- xolox/vim-easytags settings -----
" set tags=./tags;,~/.vimtags    " Where to look for tags files
" Sensible defaults
" let g:easytags_events = ['BufReadPost', 'BufWritePost']
" let g:easytags_async = 1
" let g:easytags_dynamic_files = 2
" let g:easytags_resolve_links = 1
" let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \t
nnoremap <leader>tt :TagbarToggle<CR> 
let g:tagbar_width = 23  " Set tagbar windows width
let g:tagbar_indent = 1  " SubItems' indent
let g:tagbar_expand = 1  " Expand Vim by the width of tagbar width
let g:tagbar_autofocus = 1  " Auto focus whenever loading

" for ruby, delete if you do not need
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
"autocmd BufEnter * nested :call tagbar#autoopen(0)  " auto showed whenever new file open


" ----- ctrlpvim/ctrlp.vim settings ------
nmap <leader>cp :CtrlP<CR>
nmap <leader>cm :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


" ----- tacahiroy/ctrlp-funky -----
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']


" ----- airblade/vim-gitgutter settings -----
" Open/close gitgutter with ,go
nnoremap <leader>go :GitGutterToggle<CR>
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

" ------ terryma/vim-expand-region -------
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
