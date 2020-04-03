# Script for basic setup for an ubuntu laptop

# Install base packages
function base() {
  apt-get update

  apt-get install -y\
    build-essential\
    gcc\
    python-dev\
    automake\
    autoconf\
    tree\
    jq\
    unzip\
    zip\
    gnupg\
    git\
    vim\
    tmux\
    vlc\
    irssi\
    xclip\
    tree\
    silversearcher-ag\
    htop\
    curl\
    wget\
    mercurial\
    binutils\
    bison\
    fortune\
    cowsay\
    git-extras

}

function install_docker() {
  wget -qO- https://get.docker.com/ | sh

  # Create a docker group
  sudo usermod -aG docker $USER
  echo 'Remember to restart for changes to take effect'
}

function install_nvm() {
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    echo "nvm installed";
}

# Install nodejs via n
# A bit naive though
function install_node() {
    install_nvm && nvm install --lts

    echo "current node $(node -v) version"
}

# install golang
# via awesome gvm -> https://github.com/moovweb/gvm
function install_golang() {
    wget -q -O - https://raw.githubusercontent.com/canha/golang-tools-install-script/master/goinstall.sh | bash

    echo go version
}

function usage() {
    echo -e "install.sh\n\tThis script installs my basic setup for a ubuntu laptop\n"
    echo "Usage:"
    echo "  pkgs                        - install base pkgs"
    echo "  dotfiles                    - get dotfiles"
    echo "  golang                      - install golang"
    echo "  nvm                         - install nvm"
    echo "  nodejs                      - install nodejs"
    echo "  docker                      - install docker"
    echo "  z                           - for the love of z"
}

function install_z() {
  cd ~/bin && git clone git@github.com:rupa/z.git && cd ~ && touch .z
}

function check_is_sudo() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
  fi
}

function main() {
    local cmd=$1

    if [[ -z "$cmd" ]]; then
        usage
        exit 1
    fi

    if [[ $cmd == "pkgs" ]]; then
        check_is_sudo

        base
    elif [[ $cmd == "dotfiles" ]]; then
        get_dotfiles
    elif [[ $cmd == "golang" ]]; then
        install_golang $2
    elif [[ $cmd == "nvm" ]]; then
        install_nvm $2
    elif [[ $cmd == "nodejs" ]]; then
        install_node $2
    elif [[ $cmd == "docker" ]]; then
        install_docker $2
    elif [[ $cmd == "z" ]]; then
        install_z $2
    else
        usage
    fi
}

main $@
