set nocompatible

" ================== General Config ===================
"set number relativenumber                     " Relative Line numbers
set number
set backspace=indent,eol,start                " Allow backspace in insert mode
set history=200                               " Store lots of :cmdline history
set laststatus=2                              " Always display the status bar
set showcmd                                   " Show incomplete cmds down the bottom
set showmode                                  " Show current mode down the bottom
set gcr=a:blinkon0                            " Disable cursor blink
"set novisualbell                              " No visual flash sound things
"set noerrorbells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set autoread                                  " Reload files changed outside vim
set clipboard=unnamed                         " Allows the vim clipboard to work with the system keyboard
set colorcolumn=80                            " show a column at 80 chars
set ttimeoutlen=10                            " Fast Esc key
let mapleader=" "                             " Map leader to space bar
set hidden

" Update to make current version of vim not suck with ruby files due to regex
" engine - tell it to use the old one
set re=1

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

set scrolloff=8 	                  	      " Start scrolling when we're 8 lines away from margins
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
set ttymouse=xterm2                           " Mouse setting for tmux
set ttymouse=sgr

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

call vundle#end()

" ====================== Theme Config ==================

syntax enable
"set termguicolors
set term=xterm-256color
set background=dark

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

" ====================== Ale Config ==================

let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = ['prettier', 'eslint']
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

"hi ALEErrorSign guifg=#DF8C8C
"hi ALEWarningSign guifg=#F2C38F
"let g:ale_sign_column_always = 1
"let g:ale_lint_on_save = 1

" ====================== Prettier Config ==================

"let g:prettier#exec_cmd_async = 1
"let g:prettier#config#print_width = 80
"let g:prettier#config#trailing_comma = 'none'
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync

" ====================== Eunuch Config ==================

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
set noshowmode

" ==================== Custom Functions =================
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
