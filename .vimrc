"==================== Basic ====================
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

" encoding setting
set encoding=utf-8
" multi-byte setting in vim-script
scriptencoding utf-8
if IsWindows()
  " encoding when save file
  set fileencoding=cp932
  " encodings when read file
  set fencs=ucs-bom,cp932,utf-8,iso-2022-jp,euc-jp
  " line feed code when save
  set fileformat=dos
  " line feed code when read
  set fileformats=dos,unix,mac
else
  set fileencoding=utf-8
  set fencs=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
  set fileformat=unix
  set fileformats=unix,dos,mac
endif
" fix width of em-symbol 2
set ambiwidth=double

if IsWindows()
  set runtimepath^=$HOME/.vim
  set runtimepath+=$HOME/.vim/after
endif

"-------------------- Plugin Manager --------------------
call plug#begin('~/.vim-plug')

Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
" Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'zchee/deoplete-jedi'
Plug 'tmarumt/deoplete-sasproc'
Plug 'rickhowe/diffchar.vim'
Plug 'cohama/lexima.vim'
Plug 'AndrewRadev/linediff.vim'
Plug 'nazo/pt.vim'
Plug 'tpope/vim-fugitive'
Plug 'lfilho/cosco.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Shougo/junkfile.vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
Plug 'Shougo/context_filetype.vim'
Plug 'osyo-manga/vim-precious'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'will133/vim-dirdiff'

call plug#end()

let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

"-------------------- Utility --------------------
" directory saving temporary file
let $TMPPATH = expand("~/.tmp")
if !isdirectory($TMPPATH)
  call mkdir($TMPPATH, "p")
endif
" path of backup file
set backupdir=$TMPPATH
" path of swap file
set directory=$TMPPATH
" path of undo files
set undodir=$TMPPATH

" enable to open file when not saving current file
set hidden
" refresh file
set autoread
" don't donate
set shortmess+=I
" history of vim-command
set history=1000
" time for jumping cursor
set matchtime=1
" enable to select in vim-bar
set wildmenu
set wildmode=longest:full,full
" decimal increment (decrement)
set nrformats=
" no beep
set belloff=all
" in windows, use notation of unix file path
set shellslash
" change current directory in responce to edit file
set autochdir

"-------------------- Look and Face --------------------
" display coordinate of cursor
set ruler
" display line-number
set number
set title
" highlight cursor-line
set cursorline
" fully display a line
set display=lastline
set wrap
set showmatch
" display command
set showcmd
" height of command-line
set cmdheight=2
" minimal number of screen lines to keep above and below the cursor
set scrolloff=3

"-------------------- Status-line --------------------
" display of status-line (0:off; 1: on when 2 windows; 2:on)
set laststatus=2
" left status-line
set statusline=%<%F%m%r%h%w
" right status-line
set statusline+=%=%y%{&ff}\|%{&fenc!=''?&fenc:&enc}\|%l/%L:%p%%

"-------------------- Invisible character --------------------
" visual whitespace
set list
" character of visual whitespace
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%

"-------------------- Edit --------------------
" wraparound cursor
set whichwrap=b,s,h,l,<,>,[,],~
" enable to use <backspace> anywhere
set backspace=indent,eol,start
" use clipboard
set clipboard=unnamed
" max height of popup
set pumheight=20
" file editted on left buffer
set splitright
" auto insert comment off
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END
" don't show preview
set completeopt=menuone

"-------------------- diff --------------------
set diffopt=filler,vertical
" when diff mode, wrap on and spell-check off
function! SetDiffMode()
  if &diff
    setlocal nospell
    " setlocal wrap
  endif
endfunction
autocmd VimEnter,FilterWritePre * call SetDiffMode()
" diff off when edit
autocmd WinEnter * if(winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | diffoff | endif
" diff current file
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

"-------------------- Tab and Indent --------------------
" insert space by tab-key
set expandtab
" convert tab to <number> space
set tabstop=2
" number of space by tab-key
set softtabstop=2
" number of space when generate tab
set shiftwidth=2
" insert <number of shiftwidth> when auto-indent
set smarttab
" insert same indent of up
set autoindent
" like autoindent, but more useful auto-indent based C-syntax
" set smartindent
" C-style auto-indent
" set cindent

"-------------------- Search --------------------
" increment search
set incsearch
" highlight word when increment-search
set hlsearch
" searches wrap around the end of the file
set wrapscan
" ignore lower or upper case
set ignorecase
" ignorecase when search
set smartcase
" g-option always on
" set gdefault

"-------------------- interface --------------------
if has ("mouse")
  set mouse=a
  set guioptions+=a
  set ttymouse=xterm2
endif

"-------------------- etc... --------------------
" first current directory
if isdirectory($HOME . "/Workspace")
  cd $HOME/Workspace
else
  cd $HOME
endif

"-------------------- Keymap --------------------
" copy by end of line
nnoremap Y y$
" change to normal mode
inoremap <silent> <C-j> <ESC>

" don't yank
nnoremap x "_x
nnoremap X "_X

" visual cursor move
nnoremap <Up> gk
nnoremap <Down> gj
vnoremap <Up> gk
vnoremap <Down> gj

" highlight when search on and off
nmap <silent> <Esc><Esc> :<C-u>set nohlsearch!<CR>

" buffer move
nmap <C-q>n :bn<CR>
nmap <C-q>p :bp<CR>
" nmap <C-q>b :buffers<CR>
nmap <C-q>d :bd

" tabpage keybind
" nmap <C-q>c :tabnew<CR>
" nmap <C-q>n :tabn<CR>
" nmap <C-q>p :tabp<CR>
" nmap <C-q>o :tabo<CR>
" nmap <C-q>d :tabd

" QuickFix
nmap [q :cprevious<CR>
nmap ]q :cnext<CR>
nmap [Q :<C-u>cfirst<CR>
nmap ]Q :<C-u>clast<CR>

" cursor move
inoremap <C-f> <Right>
inoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Delete>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Define <Leader> map
let mapleader = "\<Space>"

" no vim compatible
if &compatible
  set nocompatible
endif

" color setting
filetype plugin indent on
syntax enable

if has("termguicolors")
  set termguicolors
endif

colorscheme OceanicNext

"==================== Plugins ====================
" makes the % command work better
packadd! matchit

"-------------------- Filer --------------------
" banner off
let g:netrw_banner = 0
" always tree view
let g:netrw_liststyle = 3
" open file in previous buffer
let g:netrw_browse_split = 4
" size of window
let g:netrw_winsize = 25
" set file ignored
" let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" open file in right buffer by v-key
let g:netrw_altv = 1
" open file in low buffer by o-key
let g:netrw_alto = 1

"-------------------- jump to selected position --------------------
if s:plug.is_installed('denite.nvim')
  " Change file/rec command.
  if executable('rg')
    " For ripgrep
    " Note: It is slower than ag
    call denite#custom#var('file/rec', 'command',
          \ ['rg', '--files', '--glob', '!.git'])
  elseif executable('pt')
    " For Pt(the platinum searcher)
    " NOTE: It also supports windows.
    call denite#custom#var('file/rec', 'command',
          \ ['pt', '--follow', '--nocolor', '--nogroup',
          \  (has('win32') ? '-g:' : '-g='), ''])
  endif

  " Change sorters.
  call denite#custom#source(
        \ 'file/rec', 'sorters', ['sorter/sublime'])

  " Change grep source
  if executable('rg')
    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  elseif executable('pt')
    " Pt command on grep source
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  endif

  " keymap
  nnoremap [denite] <Nop>
  nmap <Leader>d [denite]
  " find file
  nnoremap <silent> [denite]f :<C-u>Denite file<CR>
  nnoremap <silent> [denite]r :<C-u>Denite file_rec<CR>
  nnoremap <silent> [denite]m :<C-u>Denite file_mru<CR>
  nnoremap <silent> [denite]d :<C-u>Denite directory_rec<CR>
  nnoremap <silent> [denite]n :<C-u>Denite directory_mru<CR>
  " select buffer
  nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
  " search
  nnoremap <silent> [denite]l :<C-u>Denite line<CR>
  " resume previous buffer
  nnoremap <silent> [denite]p :<C-u>Denite -resume<CR>
  " yank history
  nnoremap <silent> [denite]y :<C-u>Denite neoyank<CR>
  " execute command
  nnoremap <silent> [denite]c :<C-u>Denite command<CR>
  nnoremap <silent> [denite]h :<C-u>Denite command_history<CR>

  if executable('rg') || executable('pt')
    " grep keyword under cursor
    nnoremap <silent> [denite]j :<C-u>DeniteCursorWord grep line<CR>
    " grep
    nnoremap <silent> [denite]g :<C-u>Denite grep<CR>
  endif
endif

"-------------------- open and create temporary file --------------------
if s:plug.is_installed('junkfile.vim')
  let g:junkfile#directory = expand('~/.junk')

  if s:plug.is_installed('denite.nvim')
    nnoremap <silent> [denite]k :<C-u>Denite junkfile<CR>
  endif
endif

"-------------------- change filetype depending context --------------------
if s:plug.is_installed('context_filetype.vim')
  let g:context_filetype#filetypes = {
        \ 'sas' : [
        \   {
        \     'start' : '^\s*proc\s\+lua\s*\(\s\+.\+\)*;\_s*submit\s*\(\s\+.\+\)*;',
        \     'end' : '^\s*endsubmit\s*;\_s*run\s*;',
        \     'filetype' : 'lua',
        \   }
        \ ],
        \}
endif

"-------------------- auto-complete --------------------
if s:plug.is_installed('vim-misc') && s:plug.is_installed('vim-lua-ftplugin')
  let g:lua_check_syntax = 0
  let g:lua_complete_omni = 1
  let g:lua_complete_dynamic = 0
  let g:lua_define_completion_mappings = 0
endif

if s:plug.is_installed('deoplete.nvim')
  if IsWindows()
    let g:python3_host_prog=expand("C:\\Applications\\Python\\Python35\\python.exe")
  endif

  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  " Use smartcase.
  let g:deoplete#enable_smart_case = 1

  if s:plug.is_installed('vim-misc') && s:plug.is_installed('vim-lua-ftplugin')
    call deoplete#custom#source('omni', 'functions', {
          \ 'lua': 'xolox#lua#omnifunc',
          \ })
  endif

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
  function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction"}}}
endif

"-------------------- snippet code --------------------
if s:plug.is_installed('neosnippet.vim')
  " Plugin key-mappings.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)

  " SuperTab like snippets' behavior.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  "imap <expr><TAB>
  " \ pumvisible() ? "\<C-n>" :
  " \ neosnippet#expandable_or_jumpable() ?
  " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  "smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  " \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif

  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory='~/.vim/snippets'
endif

"-------------------- jump to selected position --------------------
if s:plug.is_installed('vim-easymotion')
  " invalid default mapping
  let g:EasyMotion_do_mapping = 0
  " Matching target keys by smartcase
  let g:EasyMotion_smartcase = 1

  " move to {char}
  map  <Leader>f <Plug>(easymotion-bd-f)
  nmap <Leader>f <Plug>(easymotion-overwin-f)

  " move to {char}{char}
  nmap <Leader>s <Plug>(easymotion-overwin-f2)

  " Move to line
  map <Leader>l <Plug>(easymotion-bd-jk)
  nmap <Leader>l <Plug>(easymotion-overwin-line)

  " Move to word
  map  <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <Plug>(easymotion-overwin-w)
endif

"-------------------- alignment --------------------
if s:plug.is_installed('vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

if s:plug.is_installed('linediff.vim')
  let g:linediff_first_buffer_command  = 'leftabove new'
  let g:linediff_second_buffer_command = 'rightbelow vertical new'
endif

"-------------------- multiple-cursors --------------------
if s:plug.is_installed('vim-multiple-cursors')
  " Turn off the default mappings
  " let g:multi_cursor_use_default_mapping=0

  " Map my own keys to quit
  let g:multi_cursor_quit_key='<C-c>'
  nnoremap <C-c> :call multiple_cursors#quit()<CR>

  " config with using deoplete
  if s:plug.is_installed('deoplete.nvim')
    function g:Multiple_cursors_before()
      let g:deoplete#disable_auto_complete = 1
    endfunction

    function g:Multiple_cursors_after()
      let g:deoplete#disable_auto_complete = 0
    endfunction
  endif
endif

"-------------------- nerdcommenter --------------------
if s:plug.is_installed('nerdcommenter')
  " Add spaces after comment delimiters by default
  let g:NERDSpaceDelims = 1
  " Use compact syntax for prettified multi-line comments
  let g:NERDCompactSexyComs = 1
  " Align line-wise comment delimiters flush left instead of following code indentation
  let g:NERDDefaultAlign = 'left'
  " Set a language to use its alternate delimiters by default
  let g:NERDAltDelims_java = 1
  " Add your own custom formats or override the defaults
  " let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
  " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDCommentEmptyLines = 1
  " Enable trimming of trailing whitespace when uncommenting
  let g:NERDTrimTrailingWhitespace = 1
  " Enable NERDCommenterToggle to check all selected lines is commented or not
  let g:NERDToggleCheckAllLines = 1
endif

"-------------------- cosco.vim --------------------
if s:plug.is_installed('cosco.vim')
  let g:cosco_ignore_comment_lines = 1
  autocmd FileType javascript,css,sas nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
  " autocmd FileType javascript,css,sas imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)
endif

"-------------------- trailing-whitespace --------------------
if s:plug.is_installed('vim-trailing-whitespace')
  let g:extra_whitespace_ignored_filetypes = ['denite', 'mkd']
  autocmd BufWritePre * :FixWhitespace
endif

if s:plug.is_installed('vim-dirdiff')
  let g:DirDiffEnableMappings = 0
  let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp"
  let g:DirDiffIgnore = "Id:,Revision:,Date:"
  " ignore white space in diff
  let g:DirDiffAddArgs = "-w"
endif
