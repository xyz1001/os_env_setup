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

# 1. 更新系统
echo "1. 更新系统"
echo "  1.1 修改软件源\n请手动切换软件源" && read -n 1
echo "  1.2 正在更新系统"
sudo apt update && sudo apt upgrade

# 2. 安装基础软件
echo "2. 安装基础软件"
echo "  2.1 安装编译环境"
sudo apt install g++ gcc cmake autotools python3 python3-pip qt5-qmake qt5-default lua5.3 build-essential
echo "  2.2 安装开发环境"
sudo apt install qttools5-dev-tools git gdb 
