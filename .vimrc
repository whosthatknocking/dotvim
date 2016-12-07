" Use Vim settings, rather then Vi settings
" This must be set first, because it changes other options as a side effect.
set nocompatible

" General
" set background=dark
set showmatch
set number
" set paste

" Enable folding
set foldenable          
set foldmethod=manual

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Using pathogen to load all bundles
" let g:pathogen_disabled = []
if v:version < 702
  set regexpengine=1
endif
if v:version < 701
  " call add(g:pathogen_disabled, 'jslint')
  let b:jslint_disabled=1
endif
if v:version > 703
  " concealing of double quotes
  let g:vim_json_syntax_conceal=0
endif

if v:version >= 700
  " filetype on
  " filetype off
  execute pathogen#infect()
  " call pathogen#helptags()
  set t_Co=256
  colorscheme molokai
  syntax enable
  filetype plugin indent on
endif


" Better command-line completion
set wildmenu

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep more lines of command line history
set history=1000

" Highlight current line
set cursorline

" Show the cursor position all the time
set ruler

" Display incomplete commands
set showcmd

" Enable use of the mouse for all modes
" set mouse=a
set scrolloff=3

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=1

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

" Enable spell check
set spelllang=en_us
map <F6> <Esc>:setlocal spell!<CR>
imap jj <Esc>

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

set hlsearch

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Do incremental searching
set incsearch
set smartindent

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Tab related settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" neocomplete
let g:neocomplete#enable_at_startup = 1

" Customized plugin settings

" ctrlp

" Set the working directory
" 0 - don’t manage working directory.
" 1 - the parent directory of the current file.
" 2 - the nearest ancestor that contains one of these directories or files:
"   .git/
"   .hg/
"   .bzr/
"   _darcs/
"   root.dir
"  .vimprojects
" let g:ctrlp_working_path_mode = 2
" ignore those dirs
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.swp'

" Powerline
set laststatus=2 " Always show the statusline

" Customized key mappings
let mapleader=","

" Tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Strip trailing whitespace (,ss)
function! StripTrailingWhitespaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripTrailingWhitespaces()<CR>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Toggle `set list`
noremap <leader>l :set list!<CR>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" File/Language Specific Settings

" Makefile
set makeprg=gmake
autocmd FileType make set noexpandtab | set tabstop=4 | set softtabstop=4 | set shiftwidth=4

" Shell
augroup sh
  autocmd!
  autocmd BufEnter *.sh setlocal tabstop=2 | setlocal shiftwidth=2 | setlocal softtabstop=2 | setlocal filetype=sh
augroup END

" Markdown
augroup markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Javascript

" Use Node.js for JavaScript interpretation
let $JS_CMD='node'
let g:JSLintHighlightErrorLine = 0

augroup javascript
  autocmd!
  autocmd FileType javascript set expandtab | set tabstop=4 | set softtabstop=4 | set shiftwidth=4
  autocmd BufWritePre *.py,*.js :call StripTrailingWhitespaces()
augroup END

" Other
function! Hello()
  $read !echo "Hello World\! $(date)"
endfun
