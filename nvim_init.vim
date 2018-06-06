" ln -s ~/.vim/nvim_init.vim ~/.config/nvim/init.vim

" Activate auto filetype detection
syntax on
filetype plugin indent on
filetype on
filetype plugin on
syntax enable

" indents settings
set autoindent  " enable automatic indenting for files with file type set
set backspace=indent,eol,start  " make backspace work like in other editors
set tabstop=4  " 4 spaces indent
set softtabstop=4  " vim sees 4 spaces as a tab
set shiftwidth=4  " < and > 4 spaces as a tab
set expandtab  " tabs mutate to spaces


" 2 spaces indent in html and javascript, note no space after comma
autocmd filetype html,javascript setlocal ts=2 sts=2 sw=2

" correct formatting for Makefiles
autocmd FileType make setlocal noexpandtab ts=8



set ignorecase  " ignore case when searching


" F-key mappings
nmap <F9> :NERDTreeFind<CR>
nmap <F10> :NERDTreeToggle<CR>


" Quickly edit/reload the vimrc file
" http://nvie.com/posts/how-i-boosted-my-vim/
" explicit link to place where I keep nvim settings
" so that I could do flcd there
nmap <silent> <leader>ev :e ~/.vim/nvim_init.vim<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" more natural movement between splits with Ctrl-hjkl
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" change local directory to file directory
abb flcd lcd %:p:h


" abbreviate seting rus for keyboard
abb rru set keymap=rus
abb uuk set keymap=ukr


" http://stackoverflow.com/questions/58774/how-do-you-paste-multiple-tabbed-lines-into-vi
set pastetoggle=<F6>    " F6 toggles paste mode


" plugin settings


" https://github.com/junegunn/vim-plug
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
call plug#begin('~/.local/share/nvim/plugged')
Plug 'lifepillar/vim-solarized8'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim'
Plug 'ervandew/supertab'
Plug 'ervandew/supertab'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim', {'for': ['html', 'js', 'css']}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'lambdalisue/vim-pyenv', {'for': 'python'}
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'pangloss/vim-javascript', {'for': 'js'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'mmai/wikilink'
Plug 'tpope/vim-commentary'
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
let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'
" in python3 env
" pip install flake8
" ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH
" in python2 envs install flake8 explicitly


" autorun flake8 on save
autocmd BufWritePost *.py call Flake8()
" http://flake8.readthedocs.io/en/latest/user/configuration.html
" configure flake8 in ~/.config/flake8
" [flake8]
" ignore = W293
" max-line-length=99
" exclude = .git,__pycache__,docs/source/conf.py,old,build,dist
" max-complexity = 10


" run current file as python script
" https://stackoverflow.com/questions/15449591/vim-execute-current-file
nnoremap <leader>p :!python %:p<CR>


" clear search highlighting with <leader>/
nmap <silent> <leader>/ :nohlsearch<CR>


" To map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>


" for pangloss/vim-javascript
let g:javascript_plugin_flow = 1


" open wiki
nmap <silent> <leader>hh :tabnew<CR>:tabm0<CR>:e ~/projects/wiki/Home.md<CR>:lcd %:p:h<CR>


" prettier
" single quotes over double quotes
let g:prettier#config#single_quote = 'false'
" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'
" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'false'
" avoid|always
let g:prettier#config#arrow_parens = 'avoid'
" none|es5|all
let g:prettier#config#trailing_comma = 'none'
" flow|babylon|typescript|css|less|scss|json|graphql|markdown
let g:prettier#config#parser = 'babylon'


" ctrlp

let g:ctrlp_custom_ignore = {'file': '\v(\.pyc|\.swp)$'}
nmap <silent> <leader>b :CtrlPBuffer<CR>
