" ln -s ~/.vim/nvim_init.vim ~/.config/nvim/init.vim


" F-key mappings
" F7 - flake8
nmap <F9> :NERDTreeFind<CR>
nmap <F10> :NERDTreeToggle<CR>


" Quickly edit/reload the vimrc file
" http://nvie.com/posts/how-i-boosted-my-vim/
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" more natural movement between splits with Ctrl-hjkl
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" plugin settings


" https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
call plug#begin('~/.local/share/nvim/plugged')
Plug 'lifepillar/vim-solarized8'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim'
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'lambdalisue/vim-pyenv', {'for': 'python'}
Plug 'nvie/vim-flake8', {'for': 'python'}
call plug#end()


" vim-solarized
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
colorscheme solarized8
set background=light


" NERDTree
" ignore in NERDTree files that end with pyc and ~
let NERDTreeIgnore=['\.pyc$', '\~$']


" open browser plugin
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)


" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#tips-for-using-pyenv
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'
" in python3 env
" pip install flake8
" ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH
" in python2 envs install flake8 explicitly
