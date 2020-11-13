#!/bin/bash

# 适用于Manjaro Deepin的系统个性化配置脚本

function setup_pacman() {
    sudo pacman-mirrors -i -c China -B stable -a
    grep "archlinuxcn" /etc/pacman.conf || sudo bash -c 'echo -e "[archlinuxcn]\nSigLevel = Optional TrustAll\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf' && sudo pacman -Syyu
}

function setup_pacman_pkg() {
    if [ -f "uninstall.lst" ]; then
        sudo pacman -R `comm -12 <(cat uninstall.lst | sort) <(pacman -Qnq | sort)`
    fi
    if [ -f "pacman.lst" ]; then
        sudo pacman -S $(comm -12 <(pacman -Slq|sort -u) <(cat pacman.lst | sort)) --needed && return 0
    fi
}

function setup_pip_pkg() {
    sudo pip2 install `cat pip2.lst`
    sudo pip install `cat pip3.lst`
}

function setup_dotfiles() {
    cd ~ && git clone git@github.com:xyz1001/dotfiles.git && cd dotfiles && ./install.py
    cd -2
}

function setup_npm_pkg() {
    sudo npm install `cat npm.lst` -g
}

function setup_ssh() {
    openssl rsa -in ~/.ssh/id_rsa.key -out ~/.ssh/id_rsa
    sudo chown -R `whoami`:`whoami` ~/.ssh && chmod -R 700 ~/.ssh
}

function setup_vim() {
    vim +PlugInstall +qall
    cd ~/.vim/plugged/YouCompleteMe/ || return
    ./install.py --clang-completer --system-libclang --go-completer
    cd -
}

function setup_zsh() {
    chsh -s /usr/bin/zsh
    zsh
}

function setup_tmux() {
    if [ ! -d  "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    xdotool keydown Ctrl key a keyup Ctrl key r
    xdotool keydown Ctrl key a keyup Ctrl keydown Shift key i keyup Shift
}

function setup_home() {
    sed -i 's/.*XDG_DESKTOP_DIR.*/XDG_DESKTOP_DIR="$HOME\/Desktop"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_DOWNLOAD_DIR.*/XDG_DOWNLOAD_DIR="$HOME\/Downloads"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_DOCUMENTS_DIR.*/XDG_DOCUMENTS_DIR="$HOME\/Documents"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_MUSIC_DIR.*/XDG_MUSIC_DIR="$HOME\/Musics"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_PICTURES_DIR.*/XDG_PICTURES_DIR="$HOME\/Pictures"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_VIDEOS_DIR.*/XDG_VIDEOS_DIR="$HOME\/Videos"/g' ~/.config/user-dirs.dirs
    rm -rfi ~/{文档,公共,模板,下载,音乐,视频,图片,桌面}
    mkdir ~/{repo,demo,app,Temp}
}

function setup_proxy() {
    read -p "Trojan server ssh host: " host
    read -p "Trojan server ssh port: " port
    sudo scp -P $port -r $host:/home/trojan /etc/
    sudo systemctl enable trojan.service --now

    sudo sed -i 's/socks4\s*127.0.0.1\s*9050/socks5 \t127.0.0.1 1080/g' /etc/proxychains.conf

    sudo pip2 install gfwlist2privoxy
    wget https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt -O /tmp/gfwlist.txt
    sudo gfwlist2privoxy -i /tmp/gfwlist.txt -f /etc/privoxy/gfwlist.action -p 127.0.0.1:1080 -t socks5
    sudo bash -c 'echo "actionsfile gfwlist.action" >> /etc/privoxy/config'
    sudo systemctl enable privoxy.service --now
}

function setup_input() {
    # TODO:  <02-08-20, xyz1001> #
    true
}
