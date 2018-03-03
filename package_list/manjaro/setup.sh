#!/bin/bash

# 适用于Manjaro Deepin的系统个性化配置脚本

set -o nounset                              # Treat unset variables as an error

function log() {
    space=""
    for (( i = 0; i < ${1}; i++ )); do
        space=${space}"    "
    done
    echo -e "${space}""${2}"
}

function restore_official_packages() {
    log 0 "1. 恢复官方软件包"
    log 1 "1.1 调整软件源"
    log 2 "1.1.1 更换软件源"
    sudo pacman-mirrors -i -c China -b stable
    log 2 "1.1.2 添加Archlinuxcn源"
    sudo bash -c 'echo -e "[archlinuxcn]\nSigLevel = Optional TrustAll\nServer = http://mirrors.ustc.edu.cn/archlinuxcn/\$arch" >> /etc/pacman-mirrors.conf'

    log 1 "1.2 恢复官方软件包"
    log 2 "1.2.1 卸载无用软件"
    sudo pacman -R evince evolution evolution-data-server firefox gedit sushi libreoffice-fresh
    log 2 "1.2.2 安装密钥环"
    sudo pacman -S gnupg archlinuxcn-keyring manjaro-keyring
    log 2 "1.2.3 更新软件"
    sudo pacman -Syyu
}
