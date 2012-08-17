" set nocompatible      " This should be set automatically upon detection of .vimrc

" Activate auto filetype detection
syntax on
filetype plugin indent on
filetype on
filetype plugin on
syntax enable

"eclipse elim settings
set nocompatible

set ignorecase          " Don't care about case...
set smartcase		" ... unless the query contains upper case characters
set autoindent		" Enable automatic indenting for files with ft set
set nowrap		" No fake carriage returns
set showcmd		" Show command in statusline as it's being typed
set showmatch		" Jump to matching bracket
set ruler		" Show row,col %progress through file
set laststatus=2	" Always show filename (2 is always)
set hidden	    	" Let us move between buffers without writing them.  Don't :q! or :qa! frivolously!
set softtabstop=4	" Vim sees 4 spaces as a tab
set shiftwidth=4	" < and > uses spaces
"set softtabstop=2	" Vim sees 4 spaces as a tab
"set shiftwidth=2	" < and > uses spaces
set expandtab		" Tabs mutate into spaces
set foldmethod=indent	" Default folding
set backspace=indent,eol,start  " Make backspace work like other editors.
" set tabstop=4		" 4-space indents
" set smarttab		" <TAB> width determined by shiftwidth instead of tabstop.  
set fileencoding=utf8
set fileencodings=utf8,cp1251

au BufNewFile,BufRead *.txt setf text
au FileType text set wrap 

" abbreviate seting rus for keyboard
abb rru set keymap=rus
abb uuk set keymap=ukr

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Evoke a web browser
function! Browser ()
  let line0 = getline (".")
  let line = matchstr (line0, "http[^ >]*")
  :if line==""
  let line = matchstr (line0, "ftp[^ >]*")
  :endif
  :if line==""
  let line = matchstr (line0, "file[^ >]*")
  :endif
  let line = escape (line, "#?&;|%")
  " echo line
  exec ":silent !chromium-browser ".line
endfunction

" Evoke evince (pdf viewer)
function! Evince()
  let line = getline (".")
  echo line
  exec ':silent !evince ' . "\"" . line . "\""
endfunction

" F-keys mappings

" insert current date and time
nnoremap <F2> "=strftime("%c")<CR>P
inoremap <F2> <C-R>=strftime("%c")<CR>
nnoremap <F3> :call Browser ()<CR>
nnoremap <F4> :call Evince()<CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F12> :set go-=m go-=T go-=l go-=L go-=r go-=R go-=b go-=F<CR> :set lines=999 columns=999 <CR>


" change local directory to file directory
abb flcd lcd %:p:h

let g:SaveUndoLevels = &undolevels
let g:BufSizeThreshold = 1000000
if has("autocmd")
  " Store preferred undo levels
  au VimEnter * let g:SaveUndoLevels = &undolevels
  " Don't use a swap file for big files
  au BufReadPre * if getfsize(expand("<afile>")) >= g:BufSizeThreshold | setlocal noswapfile | endif
  " Upon entering a buffer, set or restore the number of undo levels
  au BufEnter * if getfsize(expand("<afile>")) < g:BufSizeThreshold | let &undolevels=g:SaveUndoLevels | hi Cursor term=reverse ctermbg=black guibg=black | else | set undolevels=-1 | hi Cursor term=underline ctermbg=red guibg=red | endif
endif

set vb t_vb=

set foldignore=''

autocmd FileType python map <buffer> <F7> :call Pyflakes()<CR>

call pathogen#infect()
call pathogen#helptags()

" do not use quickfix with pyflakes
let g:pyflakes_use_quickfix = 0

" ignore in NERDTree files that end with pyc and ~
let NERDTreeIgnore=['\.pyc$', '\~$']

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

if has('gui_running')
    colorscheme solarized
    set background=light
else
    set background=dark
endif

se guioptions=agim
