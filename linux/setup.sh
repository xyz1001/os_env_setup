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
function updateOS()
{
    echo "1. 更新系统"
    echo -e "  1.1 修改软件源\n    请手动切换软件源..." && read -n 1
    echo "  1.2 正在更新系统"
    sudo ${UPDATE} && sudo ${UPGRADE}
}

# 2. 安装基础软件
function installBaseSoftware()
{
    echo "2. 安装基础软件"
    echo "  2.1 安装编译环境"
    sudo ${INSTALL} g++ gcc gcc-6 clang-5.0 cmake autoconf libtool autopoint gettext python3 python qt5-qmake qt5-default lua5.3 build-essential qmlscene libqt5core5a
    echo "  2.2 安装开发环境"
    sudo ${INSTALL} qttools5-dev-tools git gdb  dde-dock-dev
    echo "  2.3 安装命令行软件"
    sudo ${INSTALL} zsh tmux aria2 ffmpeg privoxy locate curl xclip tig silversearcher-ag tree cloc ncdu python-pip python3-pip nodejs nodejs-legacy npm
    if [ ${OS} = "Deepin" ]; then
        echo "卸载无用安装包"
        sudo ${UNINSTALL} vim youdao-dict steam deepin.com.qq.im
    fi
    sudo ${INSTALL} vim-gnome
    echo "  2.4 安装GUI软甲"
    sudo ${INSTALL} zeal dukto simplescreenrecorder gcolor2 xarchiver clipit gitg thunderbird shadowsocks-qt5 nautilus-nutstore netease-cloud-music vlc notepadqq sqlitestudio redshift virtualbox sogoupinyin google-chrome-stable typora electronic-wechat albert meld
    echo "安装pip软件"
    sudo pip2 install youdao
    sudo pip3 install you-get thefuck
    echo "安装npm软件"
    sudo npm install -g tldr
}

# 3. 安装额外软件
function installExtraSoftware()
{
    echo "3. 安装额外软件"
    echo "  3.1 安装proxychains-ng"
    cd /tmp && git clone https://github.com/rofl0r/proxychains-ng.git
    cd proxychains-ng && ./configure --prefix=/usr --sysconfdir=/etc && make && sudo make install && sudo make install-config
    cd ${HOME}
    echo "  3.2 安装dde-dock-monitor"
    cd /tmp && git clone https://github.com/noahsai/dde-dock-monito://github.com/noahsai/dde-dock-monitor.git
    cd dde-dock-monitor && qmake && make && sudo cp ./libdde-monitor-plugin.so /usr/lib/dde-dock/plugins
    pkill dde-dock
    echo "  3.3 安装staruml"
    google-chrome staruml.io
    echo "按任意键继续..." && read -n 1
    echo "  3.4 安装xmemo"
    google-chrome https://github.com/xyz1001/XMemo/releases
    echo "按任意键继续..." && read -n 1
    echo "  3.5 安装网易云音乐助手"
    google-chrome https://github.com/xyz1001/neteaseMusicAssistant/releases
    echo "按任意键继续..." && read -n 1
    if [ ${OS} = "Deepin" ]; then
            echo "  3.6 安装Deepinwine软件"
        sudo ${INSTALL} deepin.com.qq.office deepin.com.thunderspeed
    fi
}

# 4. 系统配置
function configSystem()
{
    echo "4. 系统配置"
    echo "  4.1 控制中心配置"
    echo "    1. 修改头像"
    echo "    2. 开启插入鼠标禁用触摸板"
    echo "    3. 关闭音效"
    echo "按任意键继续..." && read -n 1
    echo "  4.2 热区设置"
    echo "按任意键继续..." && read -n 1
    echo "  4.3 dock栏设置"
    echo "    1. 使用高效模式"
    echo "    2. 关闭无用图标"
    echo "按任意键继续..." && read -n 1
    echo "  4.4 设置时间标准，修复与Windows系统8小时间隔问题"
    sudo hwclock --systohc --localtime
    echo "  4.5 映射Caps为Ctrl"
    sudo  sed -i "s/XKBOPTIONS=\"\"/XKBOPTIONS=\"ctrl:nocaps\"/g" /etc/default/keyboard
    echo "  4.5 创建常用文件夹于HOME目录"
    mkdir ${HOME}/{App,Code,Project}
    ln -s /tmp ${HOME}/Temp
}

# 5. 软件设置
function configCliSoftware()
{
    echo "5. CLI软件设置"
    echo "  5.1 配置ssh"
    echo -e "    如果要使用已有的ssh密钥，请将.ssh文件夹止于${HOME}目录，按任意键继续..." && read -n 1
    if [ -d "${HOME}/.ssh" -a -f "${HOME}/.ssh/id_rsa" ]; then
        sudo chmod -R 700 ${HOME}/.ssh 
    else
        read -p "    输入邮箱：" mail
        ssh-keygen -t rsa -b 4096 -C "${mail}"
        cat ${HOME}/.ssh/id_rsa.pub | xclip -i -sel clipboard
        echo "    公钥已复制至系统剪贴板，请将其添加至github"
        google-chrome www.github.com/login
        echo "按任意键继续..." && read -n 1
    fi
    echo "  5.2 设置配置文件"
    echo "    1. 获取dotfiles"
    git clone git@github.com:xyz1001/dotfiles.git ${HOME}/dotfiles
    echo "    2. 安装dotfile"
    rm -rf ${HOME}/{.zshrc,.zsh,.vimrc,.vim,.tmux.conf,.gitconfig,.aria2}
    ln -s ${HOME}/dotfiles/{.zshrc,.zsh,.vimrc,.vim,.tmux.conf,.gitconfig,.aria2} ${HOME}
    echo "  5.3 设置zsh/tmux/vim"
    chsh -s /usr/bin/zsh
    git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
    curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
    echo "请手动下载clang+llvm*.tar.xz包至${HOME}/.vim/plugged/YouCompleteMe/third_party/ycmd/clang_archives目录"
    google-chrome http://releases.llvm.org/download.html
    echo "按任意键继续..." && read -n 1
    cd ${HOME}/.vim/plugged/YouCompleteMe/ && ./install.py --clang-completer
    echo "请在新打开的终端中进行zsh和tmux(Ctrl-a + Ctrl-I)插件安装，安装完成后输入exit退出返回，按任意键继续..." && read -n 1
    zsh
    echo "  5.4 设置privoxy"
    sudo sh -c 'echo "forward-socks5 / 127.0.0.1:1080 ." >> /etc/privoxy/config'
    sudo service privoxy start
    echo "    privoxy已启动，端口号8118"
    echo "  5.5 设置proxychains-ng"
    sudo sed -i "s/socks4\s*127.0.0.1\s*9050/socks5 \t127.0.0.1 1080/g" /etc/proxychains.conf
}

function configGuiSoftware()
{
    echo "6. 配置GUI软件"
    echo "  6.1 设置开机启动"
    echo "    请手动配置shadowsocks-qt5,坚果云，XMemo，albert，clipit开机启动，按任意键继续..." && read -n 1
    echo "  6.2 登录Chrome"
    echo "    请手动配置，按任意键继续..." && read -n 1
    echo "  6.3 配置shadowsocks-qt5"
    google-chrome www.weiyun.com
    echo "    请手动配置，按任意键继续..." && read -n 1
    echo "  6.4 配置坚果云"
    sed -i "s/enterprise=false/enterprise=true/g" ${HOME}/.nutstore/dist/conf/nutstore.properties
    echo "  6.5 配置staruml"
    sudo sed -i "/var pk, decrypted/a\        return \{\n            name: \"0xcb\",\n            product: \"StarUML\",\n            licenseType: \"vip\",\n            quantity: \"www.qq.com\",\n            licenseKey: \"later equals never\!\"\n        \};" /opt/staruml/www/license/node/LicenseManagerDomain.js
    echo "    在staruml中点击帮助-输入注册码(用户名：0xcb，注册码：later equals never!)-确定"
    echo "  6.6 下载Qt并安装"
    google-chrome https://www.qt.io/download-open-source-access/
    echo "    请手动配置，按任意键继续..." && read -n 1
    echo "  6.7 配置zeal，thunderbird，notepadqq，网易云音乐，Tim, 迅雷极速版等"

}

updateOS
installBaseSoftware
installExtraSoftware
configSystem
configCliSoftware
configGuiSoftware
echo "配置完成，建议立即重启，按任意键退出..." && read -n 1
