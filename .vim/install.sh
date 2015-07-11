# install bundles

bundles=(
  rking/ag.vim
  kien/ctrlp.vim
  mattn/webapi-vim
  sheerun/vim-polyglot
  shime/vim-livedown
  groenewege/vim-less
  leshill/vim-json
  pangloss/vim-javascript
  digitaltoad/vim-jade
  fatih/vim-go
  tpope/vim-fugitive
  altercation/vim-colors-solarized
  t9md/vim-choosewin
  bling/vim-airline
  godlygeek/tabular
  scrooloose/syntastic
  tpope/vim-surround
  ervandew/supertab
  cakebaker/scss-syntax.vim
  scrooloose/nerdcommenter
  mustache/vim-mustache-handlebars
  tomasr/molokai
  ekalinin/Dockerfile.vim
  othree/html5.vim
)

function install() {
  # install prerequisites
  npm i -g livedown

  # Powerline fonts
  git clone git@github.com:powerline/fonts.git &&\
    cd fonts &&\
    fc-cache -vf ~/.fonts/ &&\
    cd ../ &&\
    rm -rf fonts

  cd ~/.vim/bundles

  for bundle in ${bundles[*]}; do
    git clone "git@github.com:$bundle"
  done
}

install
