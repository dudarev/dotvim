" ln -s ~/.vim/nvim_init.vim ~/.config/nvim/init.vim

" jedi
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#tips-for-using-pyenv
let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'
" in python3 env
" pip install flake8
" ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH
" in python2 envs install flake8 explicitly


" check if file was changed
" https://github.com/neovim/neovim/issues/1936
set autoread
au FocusGained * :checktime


" Activate auto filetype detection
syntax on
filetype plugin indent on
filetype on
filetype plugin on
syntax enable


" indents settings
set autoindent                 " enable automatic indenting for files with file type set
set backspace=indent,eol,start " make backspace work like in other editors
set tabstop=4                  " 4 spaces indent
set softtabstop=4              " vim sees 4 spaces as a tab
set shiftwidth=4               " < and > 4 spaces as a tab
set expandtab                  " tabs mutate to spaces


" 2 spaces indent in html and javascript, note no space after comma
autocmd filetype html,javascript setlocal ts=2 sts=2 sw=2


" correct formatting for Makefiles
autocmd FileType make setlocal noexpandtab ts=8


set ignorecase  " ignore case when searching


" F-key mappings

" insert timestamp with F2
nmap <F2> i<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>
imap <F2> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

" open random file from the current directory
nmap <F3> :edit `ls \\| shuf -n1 \\| tail -1`<CR>
nmap <F9> :NERDTreeFind<CR>
nmap <F10> :NERDTreeToggle<CR>


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
Plug 'sbdchd/vim-run'
Plug 'lifepillar/vim-solarized8'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tyru/open-browser.vim'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim', {'for': ['html', 'js', 'css']}
" Plug 'lambdalisue/vim-pyenv', {'for': 'python'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'js'] }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'pangloss/vim-javascript', {'for': 'js'}
Plug 'tpope/vim-commentary'  " use gc
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
" Plug 'mmai/wikilink', {'for': 'markdown'}
Plug 'vimwiki/vimwiki'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular' " `:Tab /=` - align all equal signs
call plug#end()


" vim-solarized
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
colorscheme solarized8
set background=light


" NERDTree
" ignore in NERDTree files that end with pyc and ~
let NERDTreeIgnore=['\.pyc$', '\~$']


" open-browser plugin
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)


" deoplete
let g:deoplete#enable_at_startup = 1
" https://github.com/Shougo/deoplete.nvim/issues/464
autocmd FileType markdown let b:deoplete_disable_auto_complete = 1
set completeopt-=preview


" run current file as python script
" https://stackoverflow.com/questions/15449591/vim-execute-current-file
nnoremap <leader>p :!python %:p<CR>


" clear search highlighting with <leader>/
nmap <silent> <leader>/ :nohlsearch<CR>


" To map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>


" for pangloss/vim-javascript
let g:javascript_plugin_flow = 1


" open wikis
nmap <silent> <leader>gg :tabnew<CR>:tabm0<CR>:e ~/Dropbox/Thinking/Home.md<CR>:lcd %:p:h<CR>
nmap <silent> <leader>hh :tabnew<CR>:tabm0<CR>:e ~/projects/wiki/Home.md<CR>:lcd %:p:h<CR>


" ctrlp

let g:ctrlp_custom_ignore = {'file': '\v(\.pyc|\.swp)$'}
nmap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <leader>. :CtrlPTag<cr>


" http://nvie.com/posts/how-i-boosted-my-vim/
set nobackup            " do not write backup and swap files


" URL to Markdown link
nnoremap <Leader>ll :call AddMarkdownLink()<CR>
function! AddMarkdownLink()
  let url = getline (".")
  let url = matchstr (url, "http[^ >]*")
  if empty(url)
    return
  endif
  let html = system('wget -q -O - ' . shellescape(url))
  let regex = '\c.*head.*<title[^>]*>\_s*\zs.\{-}\ze\_s*<\/title>'
  let url_title = substitute(matchstr(html, regex), "\n", ' ', 'g')
  if empty(url_title)
    let url_title = url
  endif
  exe "normal 0c$[".url_title."](".url.")"
endfunction


" surround with double square brackets with 'l' character
" https://stackoverflow.com/questions/32769488/double-vim-surround-with
let g:surround_{char2nr('l')} = "[[\r]]"


" search in current directory with `F 'search term'`
" https://stackoverflow.com/questions/33285401/vim-how-do-i-map-vimgrep-command-to-avoid-typing-the-file-pattern
" http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
command! -nargs=1 F vimgrep <args> ** | cwindow 5


" disable vimwiki tab mapping
let g:vimwiki_table_mappings = 0
" https://github.com/vimwiki/vimwiki/issues/683
nmap  <Leader>f <Plug>VimwikiVSplitLink
let g:vimwiki_diary_rel_path = ''


let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']


" Quickly edit/reload the vimrc file
" http://nvie.com/posts/how-i-boosted-my-vim/
" explicit link to place where I keep nvim settings
" so that I could do flcd there
nmap <silent> <leader>ev :e ~/.vim/nvim_init.vim<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nmap <silent> <leader>c :!t count<CR>
