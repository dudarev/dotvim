Based on
http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/

```bash
git clone http://github.com/dudarev/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
git submodule init
git submodule update
```

Update all bundled modules

```bash
git submodule foreach git pull origin master
```
