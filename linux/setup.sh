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
echo "  1.1 修改软件源" && read -n 1
echo "  1.2 执行\"sudo apt update && sudo apt upgrade。\""

