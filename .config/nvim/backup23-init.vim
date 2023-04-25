" Turn compatible option off
set nocompatible

" ===================== Plugins =======================

call plug#begin(stdpath('data') . '/plugged')

" Gruvbox Theme
Plug 'morhetz/gruvbox'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linting
Plug 'w0rp/ale'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Enable unix shell commends (i.e. file actions)
Plug 'tpope/vim-eunuch'

" Change surrounding quotes & brackets
Plug 'tpope/vim-surround'

" Multiple cursors in visual mode
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" TODO: delete this plugin and replace with native vim!
" Read: https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db

" Code Commenting
Plug 'preservim/nerdcommenter'

" NerdTree File Browser
Plug 'scrooloose/nerdtree'
" NerdTree file highlighting -> NOTE: this plugin is slow AF
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Show Git status in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Auto reload unchanged buffers on disk change
Plug 'djoshea/vim-autoread'

" Rainbow parentheses matching
Plug 'luochen1990/rainbow'

" Display vertical lines on indentation levels
Plug 'Yggdroot/indentLine'

" Snippets are separated from the engine.
Plug 'honza/vim-snippets'

" LightLine (airline replacement)
Plug 'itchyny/lightline.vim'
" Bufferline onto lightline
Plug 'mengelbrecht/lightline-bufferline'
" Gruvbox for lightline
Plug 'shinchu/lightline-gruvbox.vim'
" COC into lightline
Plug 'josa42/vim-lightline-coc'

" Color HEX codes
Plug 'chrisbra/Colorizer'

" Close buffers without closing splits
Plug 'qpkorr/vim-bufkill'

" Tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" Markdown Preview
Plug 'JamshedVesuna/vim-markdown-preview'

" React Proptype Snippets
Plug 'pgilad/vim-react-proptypes-snippets'

" JavaScript, Typescript & JSX Syntax
Plug 'HerringtonDarkholme/yats.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
let g:vim_jsx_pretty_colorful_config = 1 " default 0

" Prisma
Plug 'pantharshit00/vim-prisma'

" Twig Syntax
Plug 'nelsyeung/twig.vim'
Plug 'beyondwords/vim-twig'

" Liquid Syntax
Plug 'tpope/vim-liquid'

" GraphQL
Plug 'jparise/vim-graphql'

" Rails syntax
Plug 'tpope/vim-rails'
Plug 'KurtPreston/vim-autoformat-rails'

" Python Syntax & Formatting
" Plug 'nvie/vim-flake8'
" Plug 'tell-k/vim-autopep8'
" Plug 'vim-python/python-syntax'
" Plug 'psf/black'

" Fancy Icons NOTE: this must be last
Plug 'ryanoasis/vim-devicons'

call plug#end()

" ================== General Config ===================

" Show line numbers
set number

" Scroll Limits
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Allow backspace in insert mode
set backspace=indent,eol,start

" Always display the status bar
set laststatus=2

" Show incomplete commands in status bar
set showcmd

" Show current mode down the bottom
set noshowmode

" Disable cursor blink
set gcr=a:blinkon0

" Cursor is a line
set cursorline

" GUICursor is a block in normal mode, line in insert
set guicursor=n-c:block,i-ci-ve-v:ver25,r-cr-o:hor20


" Reload files changed outside of vim
set autoread

" Show column at 120 characters
set colorcolumn=120

" Fast ESC key
set ttimeoutlen=10

" Hide unwritten buffers instead of closing them
set hidden

" Always show signcolumn for gitgutter
set signcolumn=yes

" ===================== Theming =======================

syntax on
colorscheme gruvbox
let g:gruvbox_contrast_dark="medium"
set showtabline=2

let g:lightline#bufferline#enable_devicons  = 1

let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste', 'linter_info', 'linter_hints', 'linter_errors', 'linter_warnings', 'linter_ok'],
  \             [ 'fugitive', 'gstatus', 'linter_hints' ],
  \             [ 'cocStatus', 'newfilename', 'readonly' ] ],
  \   'right': [[ 'filelength', 'lineinfo' ],
  \             [ 'percent' ],
  \             [ 'newfiletype' ]]
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ ['time'] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers',
  \   'linter_warnings': 'lightline#coc#warnings',
  \   'linter_errors': 'lightline#coc#errors',
  \   'linter_info': 'lightline#coc#info',
  \   'linter_hints': 'lightline#coc#hints',
  \   'linter_ok': 'lightline#coc#ok',
  \   'cocStatus': 'lightline#coc#status'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_info': 'info',
  \   'linter_hints': 'hints',
  \   'linter_ok': 'left'
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'readonly': 'LightlineReadonly',
  \   'gstatus': 'LightlineGitStatus',
  \   'filelength': 'LightlineFileLength',
  \   'fugitive': 'LightlineFugitive',
  \   'newfilename': 'LightlineFileName',
  \   'newfiletype': 'LightlineFiletype'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function! LightlineFileLength()
  return printf('%03d/%03d', line('.'),  line('$'))
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
" }}}
" }}}

function! LightlineGitStatus()
  return join(map(['+','~','-'], {i,v -> v.''.GitGutterGetHunkSummary()[i]}))
endfunction

function! LightlineFileName() abort
  let filename = winwidth(0) > 70 ? expand('%') : expand('%:t')
  if filename =~ 'NERD_tree'
    return ''
  endif
  return fnamemodify(filename, ":~:.")
endfunction

" =============== Custom Key Bindings  ================

" Remap Leader Key to <space>
let mapleader=" "

" Ctrl space sources the config file
map <C-s> :source ~/.config/nvim/init.vim<CR>

" Move the current file elsewhere
nnoremap <Leader>r :Move <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>

" =================== Indentation =====================

" Tabs have width of 2, uses spaces instead of tabs
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set autoindent
set smartindent

" Language specific indentation
autocmd Filetype php setlocal shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype py setlocal shiftwidth=4 softtabstop=4 tabstop=4
" Turn off indent line for json files
autocmd Filetype json let g:indentLine_enabled = 0

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype on
filetype plugin on
filetype indent on

" Display tabs and training spaces visually
set list listchars=tab:\ \ ,trail:·


" ================== Line Wrapping ====================

" Wrap lines at convenient points
set linebreak

" Move normally between wrapped lines
nmap j gj
nmap k gk

" =================== Searching ======================

" Find the next match as we type
set incsearch
" Highlight searches by default
set hlsearch
" Ignore case when searching
set ignorecase
" Dont ignore case if we search for a capital
set smartcase


" ================== Spell Checking ===================

" Enable spell checking for Australian English
set spelllang=en_au
set spell


" ==================== Swap Files =====================

" Disable any use of swap files.
" NOTE: Consider enabling if need multiple instances of vim to edit files i.e. SSH
set noswapfile
set nobackup
set nowb


" ==================== Clipboard ======================

" Allows the vim clipboard to work with the system keyboard
if !has('nvim')
  set clipboard=unnamed
endif

set clipboard+=unnamedplus

" Remap pasting in neovim so cursor doesnt go haywire
noremap p gp
noremap P gP
noremap gp p
noremap gP P


" ==================== Scrolling =====================

" Mouse scrolling in iTerm
set mouse=a

" Mouse settings for tmux
if !has('nvim')
  set ttymouse=xterm2
  set ttymouse=sgr
endif


" ===================== Buffers ======================

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


" ===================== Splits =======================

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


" ===================== Saving =======================

" Ask if you want to save before quitting
set confirm

" Map save to leader s
map <leader>s :w<CR>
nmap <leader>r :redraw!<Enter>

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Map Control e to create/open file in current folder
map <C-e> :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>

" Create folders on file save
autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))

function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction


" =================== Moving Lines ====================

" Move lines with - and = in normal or visual modes
nmap - :m -2<CR>
xnoremap - :move '<-2<CR>gv-gv
nmap = :m +1<CR>
xnoremap = :move '>+1<CR>gv-gv


" ======================= FZF ========================

" Map ctrl key to different FZF actions
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g>g :Ag<CR>
nnoremap <silent> <C-g>l :BLines<CR>
nnoremap <silent> <C-g>c :BCommits<CR>
nnoremap <silent> <C-g>b :Buffers<CR>
nnoremap <silent> <C-g>p :GFiles<CR>
nnoremap <silent> <C-g>? :GFiles?<CR>

" Find word under cursor
nnoremap <leader>g :Ag <C-R><C-W><CR>


" ==================== Git Gutter =====================

" TODO: we have disabled this to have the buffer navigation
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
set updatetime=100
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_sign_priority = 0
highlight! link SignColumn LineNr


" ================== Nerd Commenter ===================

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" ==================== Nerd Tree ======================

" Show hidden files
let NERDTreeShowHidden=1
" Map to leader f
map <leader>f :NERDTreeToggle<CR>
if exists("g:loaded_webdevicons")
	call webdevicons#refresh()
endif


" ================== Rainbow Config ===================

let g:rainbow_active = 10
" Disable rainbow brackets in nerdtree
let g:rainbow_conf = {
	\	'separately': {
	\		'nerdtree': 0,
	\	}
	\}

" ============== Markdown Preview Config ==============

" Markdown use github
let vim_markdown_preview_github=1
let vim_markdown_preview_browser="Google Chrome"


" =================== Python Config ===================

let g:python_highlight_all = 1


" ================== AutoPep8 Config ==================

" let g:autopep8_max_line_length=120
" let g:autopep8_aggressive=2
" let g:autopep8_disable_show_diff=0
" let g:autopep8_on_save = 1


" ================== Black Config =====================

" autocmd BufWritePre *.py execute ':Black'
" let g:black_linelength=120


" =================== Flake 8 Config ==================

" let g:flake8_show_in_gutter = 1
" let g:flake8_show_quickfix = 0
" autocmd BufWritePost *.py call flake8#Flake8()


" =================== ALE Config =====================
" Yes, we dont really need ALE because we have COC. COC has Eslint, TSlint &
" prettier support and is pretty great.
" However, ALE has sooo many more linters. So I'm going to try and figure out
" how to run both of them nicely together

let g:ale_linters = {'javascript': ['eslint'], 'typescript': ['eslint'], 'python': ['flake8'], 'markdown': ['remark-lint'], 'css': ['stylelint'], 'scss': ['stylelint'], 'json': ['fixjson']}
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'html': ['prettier'], 'typescript': ['prettier', 'eslint'], 'python': ['autopep8'], '*': ['remove_trailing_lines', 'trim_whitespace'], 'markdown': ['remark-lint'], 'css': ['stylelint', 'prettier'], 'scss': ['stylelint', 'prettier'], 'json': ['fixjson'], 'prisma': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_change = 'never'
let g:airline#extendsions#ale#enabled = 1

let g:ale_sign_error = 'a✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" ====================================================
" ============== CONFIGURATION FOR COC ===============
" ====================================================
" Add extensions
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-pyright',
  \ 'coc-phpls',
  \ 'coc-php-cs-fixer',
  \ 'coc-css',
  \ 'coc-stylelint',
  \ 'coc-prisma'
  \ ]

if executable('intelephense')
  augroup LspPHPIntelephense
    au!
    au User lsp_setup call lsp#register_server({
        \ 'name': 'intelephense',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'intelephense --stdio']},
        \ 'whitelist': ['php'],
        \ 'initialization_options': {'storagePath': '/tmp/intelephense'},
        \ 'workspace_config': {
        \   'intelephense': {
        \     'files': {
        \       'maxSize': 1000000,
        \       'associations': ['*.php', '*.phtml'],
        \       'exclude': [],
        \     },
        \     'completion': {
        \       'insertUseDeclaration': v:true,
        \       'fullyQualifyGlobalConstantsAndFunctions': v:false,
        \       'triggerParameterHints': v:true,
        \       'maxItems': 100,
        \     },
        \     'format': {
        \       'enable': v:true
        \     },
        \   },
        \ }
        \})
  augroup END
endif

" Create Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" TODO: remap these
" Use `[` and `]` to navigate diagnostics
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" NOTE: use <C-o> to jump back

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code. // TODO: revist this -> nerd tree
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects i.e. change in function, change in class
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" TODO: wtf is this shit
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" NOTE: this is disabled for now.
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" NOTE: All of these have been remapped to backslash because I've decided to
" use space as my leader key
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <Bslash>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <Bslash>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <Bslash>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <Bslash>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <Bslash>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <Bslash>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <Bslash>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <Bslash>p  :<C-u>CocListResume<CR>

" ====================================================
" ============ END CONFIGURATION FOR COC =============
" ====================================================

" ================ Snippets Config ===================

" Make <tab> used for trigger completion, completion confirmation, snippet
" expand and jump
" NOTE: Uncomment this code in order to make tab work for selection!

" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? coc#_select_confirm() :
      " \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()

" function! s:check_back_space() abort
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" let g:coc_snippet_next = '<tab>'

" TODO: install ALE and handle everything -> use linter instead of coc or
" merge them ?
