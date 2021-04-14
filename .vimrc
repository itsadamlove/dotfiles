set nocompatible

" ================== General Config ===================
"set number relativenumber                     " Relative Line numbers
set number
set backspace=indent,eol,start                " Allow backspace in insert mode
set history=200                               " Store lots of :cmdline history
set laststatus=2                              " Always display the status bar
set showcmd                                   " Show incomplete cmds down the bottom
set noshowmode                                  " Show current mode down the bottom
set cursorline
set gcr=a:blinkon0                            " Disable cursor blink
"set novisualbell                              " No visual flash sound things
"set noerrorbells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set autoread                                  " Reload files changed outside vim
if !has('nvim')
  set clipboard=unnamed                         " Allows the vim clipboard to work with the system keyboard
endif
set colorcolumn=120                            " show a column at 80 chars
set ttimeoutlen=10                            " Fast Esc key
let mapleader=" "                             " Map leader to space bar
set hidden
set confirm

" Update to make current version of vim not suck with ruby files due to regex
" engine - tell it to use the old one
set re=1

" =================== Spell Checking ====================
set spelllang=en_au
set spell

" ==================== Swap Files ====================

set noswapfile
set nobackup
set nowb

" ================== Persistent Undo ==================

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ======================= Folds =======================

"set nofoldenable                            " Disable folding

" ==================== Moving Lines ====================
nmap - :m -2<CR>
nmap = :m +1<CR>

" ===================== Scrolling =====================

set scrolloff=12 	                  	      " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ===================== Search =======================

set incsearch                               " Find the next match as we type
set hlsearch                                " Highlight searches by default
set ignorecase                              " Ignore case when searching...
set smartcase                               " ... Unless we type a capital

" ===================== Indentation ==================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

autocmd Filetype php setlocal shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype py setlocal shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype json let g:indentLine_enabled = 0

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype on
filetype plugin on
filetype indent on

set list listchars=tab:\ \ ,trail:·           " Display tabs and trailing spaces visually

" ===================== Wrapping ==================

"set nowrap                                    " Don't wrap lines
set linebreak                                 " Wrap lines at convenient points

" Move normally between wrapped lines
nmap j gj
nmap k gk

" ========================  Buffers ====================

" Use buffers instead of tabs.

" Move to the next buffer
nmap <leader>l :bn<CR>

" Move to the previous buffer
nmap <leader>h :bp<CR>

" Close current buffer but keep split (from vimBufkill)
nmap <leader>w :BD<CR>

" Close all buffers
nmap <leader>q :bufdo bdelete<CR>

" To open a new empty buffer
nmap <leader>t :enew<cr>

" switch between the last two files
nnoremap <leader><leader> <c-^>

" ========================  Splits ====================

" Quicker movement between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Open new splits
map vv <C-W>v
map ss <C-W>s

" Close Splits
map W  <C-W>q

" Open new split panes to right and bottom - feels more natural
set splitbelow
set splitright

" Window Split Resizing
nnoremap <leader>, :vertical resize +5<CR>
nnoremap <leader>. :vertical resize -5<CR>
nnoremap <leader>= <C-w>=
nnoremap <silent> <Leader>[ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>] :exe "resize " . (winheight(0) * 2/3)<CR>

autocmd VimResized * wincmd = " Automatically resize splits when resizing window

" ====================== Line Movement ==================
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" ====================== Save Settings ==================

" Map save to leader s
map <leader>s :w<CR>
nmap <Leader>r :redraw!<Enter>

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Map Control e to create/open file in current folder
map <C-e> :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>

" Create folders on file save
autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))

" ====================== iTerm Settings ==================

set mouse=a                                   " Mouse scrolling in iTerm
if !has('nvim')
  set ttymouse=xterm2                           " Mouse setting for tmux
  set ttymouse=sgr
endif

" ====================== Plugins ========================

" The following 3 lines are required for vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" NerdTree File Browser
Plugin 'scrooloose/nerdtree'

" fzf Fuzy Finder
" super awesome fuzzy finder for all the things (Replaced ctrl P)
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plugin 'junegunn/fzf.vim'

" File Actions
Plugin 'tpope/vim-eunuch'                         " Vim wrapper for most common UNIX shell commands

" Text Formatting
Plugin 'tpope/vim-surround'                       " Easy way to swap & remove surrounding quotes or brackets
Plugin 'jiangmiao/auto-pairs'                     " Auto pairs
Plugin 'terryma/vim-multiple-cursors'             " Multiple cursor matching
Plugin 'scrooloose/nerdcommenter'                 " Commenting Shorcuts
"Plugin 'prettier/vim-prettier'                    " Wrapper for prettier
Plugin 'djoshea/vim-autoread'                     " Auto reload unchanged buffers on disk change
Plugin 'luochen1990/rainbow'                      " Rainbow parentheses matching
Plugin 'Yggdroot/indentLine'                      " Lines on indentation level

if has('python3')
  " Snippets [Ultisnips]
  Plugin 'SirVer/ultisnips'                         " Track the engine.
  Plugin 'honza/vim-snippets'                       " Snippets are separated from the engine.

  " AutoCompletion - Requires compiling
  Plugin 'Valloric/YouCompleteMe'                   " Auto Suggestions
endif

" SupeTab - To make snippets and auto complete work nicely together
Plugin 'ervandew/supertab'                        " Use Tab for insert completion needs

" Themes
Plugin 'vim-airline/vim-airline'                  " Bottom Airline Bar
Plugin 'vim-airline/vim-airline-themes'           " Airline themes
Plugin 'morhetz/gruvbox'                          " Gruvbox Theme
"Plugin 'mhartington/oceanic-next'                 " Oceanic Next Colour Scheme

" Git
Plugin 'tpope/vim-fugitive'                       " Git Wrapper
Plugin 'airblade/vim-gitgutter'                   " Git gutter for vim

" Layout
Plugin 'qpkorr/vim-bufkill'                       " Allows for buffer closing without split closing
Plugin 'christoomey/vim-tmux-navigator'           " Vim and tmux harmony

" Markdown
Plugin 'JamshedVesuna/vim-markdown-preview'       " Vim Markdown Generation

" HTML
Plugin 'slim-template/vim-slim.git'               " Syntax Highlighting for Slim
Plugin 'chrisbra/Colorizer'                       " Color Hex codes and color names

" Javascript
Plugin 'pangloss/vim-javascript'                  " Better JS Syntax
Plugin 'othree/javascript-libraries-syntax.vim'   " Syntax for JS Libraries
Plugin 'jelera/vim-javascript-syntax'

" TypeScript
Plugin 'leafgarland/typescript-vim'               " TypeScript Syntax Highlighting
Plugin 'HerringtonDarkholme/yats.vim'

" Twig
Plugin 'nelsyeung/twig.vim'                        " Twig Syntax
Plugin 'beyondwords/vim-twig'

" Liquid                                           " Liquid Syntax
Plugin 'tpope/vim-liquid'

" Django
" Plugin 'lambdalisue/vim-django-support' " This shit is slow
Plugin 'nvie/vim-flake8'
Plugin 'tell-k/vim-autopep8'
Plugin 'vim-python/python-syntax'
Plugin 'psf/black'

" JSX / TSX
Plugin 'maxmellon/vim-jsx-pretty'
let g:vim_jsx_pretty_colorful_config = 1 " default 0

Plugin 'mattn/emmet-vim'                          " Expend CSS selectors into JSX

" Liniting
Plugin 'w0rp/ale'                                 " Async Linting tool

" Ruby
Plugin 'tpope/vim-endwise'                        " Automatically add 'end' to things like loops
Plugin 'tpope/vim-rails'                            " Better Rails Syntax
Plugin 'KurtPreston/vim-autoformat-rails'           " Formatting fixes

" Goyo
Plugin 'junegunn/goyo.vim'                            " Distraction free writing
Plugin 'junegunn/limelight.vim'                       " Focus current paragraph

if has('nvim')
  " Plugin 'glacambre/firenvim'                      " nvim in browser fields
endif

call vundle#end()

" ====================== Theme Config ==================

syntax enable
"set termguicolors
"
"
if !has('nvim')
  set term=xterm-256color
  set background=dark
endif

" Gruvbox
colorscheme gruvbox
let g:gruvbox_contrast_dark="medium"
let g:airline_theme='gruvbox'

" Oceanic Next
"colorscheme OceanicNext
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:airline_theme='oceanicnext'

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_detect_spell=0

" Set vertical bar as cursor in insert mode
if exists('$TMUX')
  let &t_SI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=1\x7\<esc>\\"
  let &t_EI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=0\x7\<esc>\\"
else
  let &t_SI = "\<esc>]50;CursorShape=1\x7"
  let &t_EI = "\<esc>]50;CursorShape=0\x7"
endif

" ====================== NERDTree Config ==================

let NERDTreeShowHidden=1                      " Show hidden files
"map <C-f> :NERDTreeToggle<CR>
map <Leader>f :NERDTreeToggle<CR>

" ====================== NERDTree Config ==================

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" ============= AutoComplete & Snippets Config ===========
let g:ycm_path_to_python_interpreter = '/Users/adam/anaconda3/bin/python3'
if has('python3')
  " make YCM compatible with UltiSnips (using supertab)
  let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
  let g:ycm_key_list_accept_completion = ['<C-y>']
  let g:SuperTabDefaultCompletionType = '<C-n>'

  let g:UltiSnipsExpandTrigger = "<tab>"
  let g:UltiSnipsJumpForwardTrigger = "<c-f>"
  let g:UltiSnipsJumpBackwardTrigger = "<c-b>"

  " Auto CSS recommendations for YCM
  let g:ycm_semantic_triggers = {
        \   'css': [ 're!^\s{2}', 're!:\s+' ],
        \ }

  autocmd FileType javascript UltiSnipsAddFiletypes html
  autocmd FileType typescript UltiSnipsAddFiletypes html
  autocmd FileType edge UltiSnipsAddFiletypes html
  autocmd FileType liquid UltiSnipsAddFiletypes html
endif

" ====================== FZF Config ==================

nnoremap <C-p> :Files<CR>

"nnoremap <C-b> :Buffers<CR>
nnoremap <C-g>c :Commands<CR>

nnoremap <C-g>g :Ag<CR>
nnoremap <C-g>l :BLines<CR>
nnoremap <C-g>c :BCommits<CR>
nnoremap <C-g>b :Buffers<CR>
nnoremap <C-g>p :GFiles<CR>
nnoremap <C-g>? :GFiles?<CR>

" Find word under cursor
nnoremap <Leader>g :Ag <C-R><C-W><CR>

" ====================== GitGutter Config ==================

" Remove gitfutter mappings to free up 'h' key
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=100

" ====================== Markdown Config ==================

" Markdown use github
let vim_markdown_preview_github=1
let vim_markdown_preview_browser="Google Chrome"

" ====================== Javascript Config ==================

let g:jsx_ext_required = 0                     " Allow JSX in normal Javascript files

" ====================== Emmet Config ==================

let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \      'extends' : 'jsx',
      \  },
      \}

" ====================== Python Config ==================
let g:python_highlight_all = 1

" ====================== AutoPep8 Config ==================
let g:autopep8_max_line_length=120
let g:autopep8_aggressive=2
let g:autopep8_disable_show_diff=0
let g:autopep8_on_save = 1

" ====================== Black Config ==================
autocmd BufWritePre *.py execute ':Black'
let g:black_linelength=120

" ====================== Flake 8 Config ==================
let g:flake8_show_in_gutter = 1
let g:flake8_show_quickfix = 0
autocmd BufWritePost *.py call flake8#Flake8()

" ====================== Ale Config ==================

let g:ale_linters = {'javascript': ['eslint'], 'python': ['flake8'], 'markdown': ['remark-lint']}
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'python': ['autopep8'], '*': ['remove_trailing_lines', 'trim_whitespace'], 'markdown': ['remark-lint']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_change = 'never'
let g:airline#extendsions#ale#enabled = 1

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Navigate between errors quickly
" NEVER WANT TO REMAP <C-[> because is is synonymous with mapping <esc>
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

nmap <leader>d <Plug>(ale_fix)

" ====================== Prettier Config ==================

"let g:prettier#exec_cmd_async = 1
"let g:prettier#config#print_width = 80
"let g:prettier#config#trailing_comma = 'none'
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync

" ====================== Move Current File ==================

nnoremap <Leader>r :Move <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>

" ====================== Rainbow Config ==================

let g:rainbow_active = 10

" ====================== MacVim / GUI Changes ==========
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guifont=Ubuntu\ Mono\ derivative\ Powerline:h16
set linespace=2

set statusline=%=&P\ %f\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\

" ==================== Custom Functions =================
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

autocmd BufEnter *.png,*.jpg,*gif exec "! ~/.iterm2/imgcat ".expand("%") | :bw

" ====================== Source Dotfiles ====================
map <C-s> :source ~/.vimrc<CR>

" ====================== Goyo Settings ====================
map <ENTER> :Goyo<CR>
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowcmd
  set scrolloff=999
  set nocursorline
  Limelight
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showcmd
  set scrolloff=12
  set cursorline
  Limelight!
  AirlineRefresh!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
