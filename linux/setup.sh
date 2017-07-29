#!/bin/bash - 
#===============================================================================
#
#          FILE: setup.sh
# 
#         USAGE: ./setup.sh 
# 
#   DESCRIPTION: 全新Linux系统环境搭建脚本
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Zhang Fan (张帆), zgzf1001@gmail.com
#  ORGANIZATION: 
#       CREATED: 2017年07月19日 13时13分53秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

OS=$(cat /etc/issue | head -n 1 | cut -d' ' -f1)
UPDATE=""
UPGRADE=""
INSTALL=""
UNINSTALL=""
if [ ${OS} = "Deepin" ]; then
    UPDATE="apt update"
    UPGRADE="apt upgrade"
    INSTALL="apt install"
    UNINSTALL="apt purge"
elif [ ${OS} = "Manjaro" ]; then
    UPDATE="pacman -Sy"
    UPGRADE="pacman -Su"
    INSTALL="pacman -S"
    UNINSTALL="pacman -R"
fi

# 1. 更新系统
echo "1. 更新系统"
echo -e "  1.1 修改软件源\n	请手动切换软件源..." && read -n 1
echo "  1.2 正在更新系统"
sudo ${UPDATE} && sudo ${UPGRADE}

# 2. 安装基础软件
echo "2. 安装基础软件"
echo "  2.1 安装编译环境"
sudo ${INSTALL} g++ gcc gcc-6 clang-5.0 cmake autoconf libtool autopoint gettext python3 python qt5-qmake qt5-default lua5.3 build-essential qmlscene libqt5core5a
echo "  2.2 安装开发环境"
sudo ${INSTALL} qttools5-dev-tools git gdb  dde-dock-dev
echo "  2.3 安装命令行软件"
sudo ${INSTALL} zsh tmux aria2 ffmpeg privoxy locate curl xclip tig silversearcher-ag tree cloc ncdu python-pip python3-pip nodejs nodejs-legacy npm
if [ OS = "Deepin" ]; then
    echo "卸载无用安装包"
    sudo ${UNINSTALL} vim youdao-dict steam deepin.com.qq.im
fi
sudo ${INSTALL} vim-gnome
echo "  2.4 安装GUI软甲"
sudo ${INSTALL} zeal dukto simplescreenrecorder gcolor2 xarchiver clipit gitg thunderbird shadowsocks-qt5 nautilus-nutstore netease-cloud-music vlc notepadqq sqlitestudio redshift virtualbox sogoupinyin google-chrome-stable typora
echo "安装pip软件"
sudo pip2 install youdao
sudo pip3 install you-get thefuck
echo "安装npm软件"
sudo npm install -g tldr

# 3. 安装额外软件
echo "3. 安装额外软件"
echo "  3.1 安装staruml"
google-chrome staruml.io
echo "按任意键继续..." && read -n 1
echo "	3.2 安装
