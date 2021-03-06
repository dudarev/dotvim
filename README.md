## Installing

Based on
http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/

```bash
git clone git@github.com:dudarev/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
ln -s ~/.vim/mvimrc ~/.mvimrc
ln -s ~/.vim/ideavimrc ~/.ideavimrc
cd .vim
git submodule init
git submodule update
```


## Neovim

```
ln -s ~/.vim/nvim_init.vim ~/.config/nvim/init.vim
ln -s ~/.vim/keymap ~/.config/nvim/keymap
```

To install Plug:

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

In `nvim`: `:PlugInstall`.

Based on https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim

```
pyenv install 2.7..  # put current version
pyenv install 3.6..

pyenv virtualenv 2.7.11 neovim2
pyenv virtualenv 3.4.4 neovim3

pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path

pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path

pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH
```

Make sure that the path is set correctly in `~/.config/nvim/init.vim`

```
let g:python_host_prog = '/full/path/to/neovim2/bin/python'
let g:python3_host_prog = '/full/path/to/neovim3/bin/python'
```

In all python2 environments install flake8 explicitly so that it overwrites python3 flake8.


## When new submodule is installed in remote

```bash
git submodule update --init --recursive
```


## Update all bundled modules

```bash
git submodule foreach git pull origin master
```


## Install a new bundle

```bash
git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
git add .
git commit -m "Install Fugitive.vim bundle as a submodule."
```


## To remove a submodule

1. Delete the relevant section from the .gitmodules file.
2. Delete the relevant section from .git/config.
3. Run git rm --cached path_to_submodule (no trailing slash).
4. Commit and delete the now untracked submodule files.
