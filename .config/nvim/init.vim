set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set clipboard+=unnamedplus
set guicursor=n-c:block,i-ci-ve-v:ver25,r-cr-o:hor20

noremap p gp
noremap P gP
noremap gp p
noremap gP P

map <C-s> :source ~/.config/nvim/init.vim<CR>
