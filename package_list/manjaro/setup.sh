#!/bin/bash

# 适用于Manjaro Deepin的系统个性化配置脚本

set -o nounset                              # Treat unset variables as an error

function log() {
    space=""
    for (( i = 0; i < ${1}; i++ )); do
        space=${space}+"    "
    done
    echo -e "${space}"+"${2}"
}

function restore_official_packages() {
    log(0, "1. 恢复官方软件包")
    echo -e "   1.1 调整软件源"
    echo -e "       1.1.1 更换软件源"
    sudo pacman-mirrors -i -c China -b stable
    echo -e "       1.2 添加Archlinuxcn源"
    sudo bash -c 'echo -e "[archlinuxcn]\nSigLevel = Optional TrustAll\nServer = http://mirrors.ustc.edu.cn/archlinuxcn/\$arch" >> /etc/pacman-mirrors.conf'


    echo -e "       1.1.1 更换软件源"
}
