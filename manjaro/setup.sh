#!/bin/bash

# 适用于Manjaro Deepin的系统个性化配置脚本

function setup_pacman() {
    sudo pacman-mirrors -i -c China -B stable -a
    grep "archlinuxcn" /etc/pacman.conf || sudo bash -c 'echo -e "[archlinuxcn]\nSigLevel = Optional TrustAll\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf' && sudo pacman -Syyu
}

function setup_pacman_pkg() {
    if [ -f "pacman.lst" ]; then
        sudo pacman -S $(comm -12 <(pacman -Slq|sort -u) <(cat pacman.lst | sort)) --needed && return 0
    fi
}

function setup_dotfiles() {
    sudo pip install dotfilesmanager
    cd ~ && git clone git@github.com:xyz1001/dotfiles.git && dfm install
    cd -
}

function setup_pip_pkg() {
    pip install `cat pip3.lst`
}

function setup_npm_pkg() {
    yarn install `cat npm.lst` -g
}

function setup_home() {
    sed -i 's/.*XDG_DESKTOP_DIR.*/XDG_DESKTOP_DIR="$HOME\/Desktop"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_DOWNLOAD_DIR.*/XDG_DOWNLOAD_DIR="$HOME\/Downloads"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_DOCUMENTS_DIR.*/XDG_DOCUMENTS_DIR="$HOME\/Documents"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_MUSIC_DIR.*/XDG_MUSIC_DIR="$HOME\/Musics"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_PICTURES_DIR.*/XDG_PICTURES_DIR="$HOME\/Pictures"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_VIDEOS_DIR.*/XDG_VIDEOS_DIR="$HOME\/Videos"/g' ~/.config/user-dirs.dirs
    rm -rfi ~/{文档,公共,模板,下载,音乐,视频,图片,桌面}
    mkdir ~/{Repos,Demo,Temp}
}

function setup_ssh() {
    cd /tmp && git clone https://gitee.com/xyz1001/privacy.git && cd privacy && ./install.sh
    cd -2
}

function setup_proxy() {
    read -p "Trojan server ssh host: " host
    read -p "Trojan server ssh port: " port
    read -p "Trojan server username: " username
    sudo scp -P $port -r $username@$host:/home/trojan /etc/
    sudo cp /etc/trojan/trojan.service /etc/systemd/system/
    sudo systemctl enable trojan.service --now

    sudo sed -i 's/socks4\s*127.0.0.1\s*9050/socks5 \t127.0.0.1 1080/g' /etc/proxychains.conf

    sudo pip2 install gfwlist2privoxy
    wget https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt -O /tmp/gfwlist.txt
    sudo gfwlist2privoxy -i /tmp/gfwlist.txt -f /etc/privoxy/gfwlist.action -p 127.0.0.1:1080 -t socks5
    sudo bash -c 'echo "actionsfile gfwlist.action" >> /etc/privoxy/config'
    sudo systemctl enable privoxy.service --now
}

function setup_vim() {
    nvim +PlugInstall +qall
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
