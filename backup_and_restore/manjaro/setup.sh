#!/bin/bash

# 适用于Manjaro Deepin的系统个性化配置脚本

#######################################################################
#                                utils                                #
#######################################################################

function log() {
    space=""
    for (( i = 0; i < ${1}; i++ )); do
        space=${space}"    "
    done
    echo -e "${space}""${2}"
    sleep 1
}

function check_file() {
    if [ ! -f "${1}" ]; then
        read -p "未发现文件${1}，按任意键跳过此步，或放入此文件后按任意键继续..." -rn 1
    fi

    if [ -f "${1}" ]; then
        return 0
    fi
    return 1
}

function check_dir() {
    if [ ! -d "${1}" ]; then
        read -p "未发现文件夹${1}，按任意键跳过此步，或放入此文件夹后按任意键继续..." -rn 1
    fi

    if [ -d "${1}" ]; then
        return 0
    fi
    return 1
}

function repair_pacman() {
    sudo rm -r /etc/pacman.d/gnupg || return 1
    sudo pacman-key --init || return 1
    sudo pacman-key --populate archlinux manjaro || return 1
    sudo pacman-key --refresh-keys  || return 1
    sudo pacman -Sc || return 1
}

function press_any_key_to_continue() {
    if [[ $# != 0 ]]; then
        echo -e "${1}"
    fi
    read -p "按任意键继续..." -rn 1
}

function choose() {
    read -rp "${1}""(y/n): " choose
    if [[ "${choose}" = "y" ]]; then
        return 0
    fi
    return 1
}

#######################################################################
#                                steps                                #
#######################################################################

function restore_official_packages() {
    log 0 "1. 恢复官方软件包"
    log 1 "1.1 调整软件源"
    log 2 "1.1.1 更换软件源"
    sudo pacman-mirrors -i -c China -B stable -a
    log 2 "1.1.2 添加Archlinuxcn源"
    grep "archlinuxcn" /etc/pacman.conf || sudo bash -c 'echo -e "[archlinuxcn]\nSigLevel = Optional TrustAll\nServer = http://mirrors.ustc.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf' && sudo pacman -Syy

    log 1 "1.2 恢复官方软件包"
    log 2 "1.2.1 卸载无用软件"
    wget https://github.com/xyz1001/software-notes/raw/master/backup_and_restore/manjaro/uninstall.lst -O /tmp/uninstall.lst
    check_file /tmp/uninstall.lst && sudo pacman -R `comm -12 <(cat /tmp/uninstall.lst | sort) <(pacman -Qnq | sort)`
    log 2 "1.2.2 安装密钥环"
    sudo pacman -Syy && sudo pacman -S gnupg archlinux-keyring manjaro-keyring --needed
    log 2 "1.2.3 更新软件"
    sudo pacman -Syyu
    log 2 "1.2.4 安装已备份官方软件包"
    wget https://github.com/xyz1001/software-notes/raw/master/backup_and_restore/manjaro/pacman.lst -O /tmp/pacman.lst
    check_file /tmp/pacman.lst && sudo pacman -S $(comm -12 <(pacman -Slq|sort -u) <(cat pacman.lst | sort)) --needed && return 0
    if choose 'Pacman安装失败，若错误提示为"Signature from xxx is unknown trust, installation failed"，可尝试修复，是否立即修复？'; then
        if repair_pacman; then
            sudo pacman -S $(comm -12 <(pacman -Slq|sort -u) <(cat pacman.lst | sort)) --needed
        fi
    fi
}

function base_env_config() {
    log 0 "2. 配置基本环境"
    log 1 "2.1 配置SSH"
    check_dir ~/.ssh && sudo chown -R `whoami`:`whoami` ~/.ssh && chmod -R 700 ~/.ssh
    log 1 "2.2 安装dotfiles"
    cd ~ && git clone git@github.com:xyz1001/dotfiles.git && cd dotfiles && ./install.py
    log 1 "2.3 配置ss-qt5"
    press_any_key_to_continue "请手动配置ss-qt5，端口设置为1080"
    ss-qt5
    log 1 "2.4 配置privoxy"
    sudo bash -c 'echo "forward-socks5 / 127.0.0.1:1080 ." >> /etc/privoxy/config'
    sudo systemctl start privoxy.service
    log 1 "2.5 调整HOME目录结构"
    log 2 "2.5.1 修改中文目录为英文目录"
    sed -i 's/.*XDG_DESKTOP_DIR.*/XDG_DESKTOP_DIR="$HOME\/Desktop"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_DOWNLOAD_DIR.*/XDG_DOWNLOAD_DIR="$HOME\/Downloads"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_DOCUMENTS_DIR.*/XDG_DOCUMENTS_DIR="$HOME\/Documents"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_MUSIC_DIR.*/XDG_MUSIC_DIR="$HOME\/Musics"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_PICTURES_DIR.*/XDG_PICTURES_DIR="$HOME\/Pictures"/g' ~/.config/user-dirs.dirs
    sed -i 's/.*XDG_VIDEOS_DIR.*/XDG_VIDEOS_DIR="$HOME\/Videos"/g' ~/.config/user-dirs.dirs
    log 2 "2.5.2 删除无用目录"
    cd ~ && rmdir 文档 公共 模板 下载 音乐 桌面 视频; rm -r 图片
    log 2 "2.5.3 创建必需目录"
    mkdir ~/{Project,Code,Application,Temp}
}

function restore_extra_packages() {
    log 0 "3. 恢复其他软件包"
    log 1 "3.1 配置安装环境"
    log 2 "3.1.1 配置终端代理"
    export https_proxy=127.0.0.1:8118
    export http_proxy=127.0.0.1:8118
    log 2 "3.1.2 配置git代理"
    git config --global http.proxy 'socks5://127.0.0.1:1080'
    git config --global https.proxy 'socks5://127.0.0.1:1080'
    log 1 "3.2 安装Python软件"
    sudo pip2 --proxy 127.0.0.1:8118 install youdao
    sudo pip --proxy 127.0.0.1:8118 install you-get thefuck tldr cppman icdiff
    log 1 "3.3 安装npm软件"
    sudo -E npm install hexo-cli -g
    log 1 "3.4 源码软件"
    log 2 "3.4.1 dde-system-monitor"
    cd /tmp && git clone git@github.com:xyz1001/dde-system-monitor.git
    cd dde-system-monitor && mkdir build && cd build
    qmake .. && make
    sudo cp libdock-system-monitor.so /usr/lib/dde-dock/plugins && pkill dde-dock
    log 2 "3.4.2 XMemo"
    cd /tmp && git clone git@github.com:xyz1001/XMemo.git
    cd XMemo && mkdir build && cd build
    qmake ../src && make
    sudo cp -r ../package/fakeroot/usr/* /usr/
    sudo cp xmemo /usr/local/bin
    log 2 "3.4.3 cppiniter"
    cd /tmp && git clone git@github.com:xyz1001/cppiniter.git
    cd cppiniter && sudo ./install.py
    log 1 "3.5 安装AUR软件"
    log 2 "3.5.1 albert"
    yaourt -S albert
    log 2 "3.5.2 deepinwine系列"
    if choose "deepinwine软件安装较慢且易出错，是否现在安装？"; then
        yaourt -S deepin.com.qq.office
        yaourt -S deepin.com.thunderspeed
        yaourt -S deepin.com.wechat
    fi
    log 2 "3.5.3 其他软件"
    wget https://github.com/xyz1001/software-notes/raw/master/backup_and_restore/manjaro/yaourt.lst -O /tmp/yaourt.lst
    while [ $? -eq 0 ]; do
        check_file /tmp/yaourt.lst && yaourt -S $(< /tmp/yaourt.lst) --needed --noconfirm && return 0 || choose "是否重试？"
    done
}

function software_config() {
    log 0 "4 软件配置"
    log 1 "4.1 zsh"
    chsh -s /usr/bin/zsh
    press_any_key_to_continue "即将运行zsh并自动安装插件，请在插件安装完成后退出zsh以继续配置"
    zsh
    log 1 "4.2 tmux"
    log 2 "4.2.1 添加快捷键"
    echo 'deepin-terminal -e tmux -2'| xclip -selection clipboard
    press_any_key_to_continue "请手动在控制中心中添加tmux终端快捷键Ctrl+Shift+T，命令为deepin-terminal -e tmux -2，已复制到系统剪贴板"
    log 2 "4.2.2 安装插件管理器tpm"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    log 2 "4.2.3 安装插件"
    press_any_key_to_continue "即将运行tmux，请手动按下组合键Ctrl+a,I进行tmux插件的安装，安装完成后退出tmux以继续配置"
    tmux
    log 1 "4.3 vim"
    log 2 "4.3.1 安装vim插件"
    vim +PlugInstall +qall
    log 2 "4.3.2 编译YouCompleteMe依赖"
    cd ~/.vim/plugged/YouCompleteMe/ && ./install.py --clang-completer --system-libclang
    log 1 "4.4 proxychains"
    sudo sed -i 's/socks4\s*127.0.0.1\s*9050/socks5 \t127.0.0.1 1080/g' /etc/proxychains.conf
    log 1 "4.5 Chrome"
    press_any_key_to_continue "即将运行Chrome，请在登陆Chrome后不要关闭Chrome，直接返回终端继续配置"
    google-chrome-stable --proxy-server=socks5://127.0.0.1:1080
    log 1 "4.6 深度终端"
    press_any_key_to_continue '1. 调整主题为"solarized dark"\n2. 调整字体为firacode\n3. 设置启动时最大化\n'
    sed -i "s/print_notify_after_script_finish.*/print_notify_after_script_finish=false/g" ~/.config/deepin/deepin-terminal/config.conf
    sed -i "s/show_quakewindow_tab.*/show_quakewindow_tab=false/g" ~/.config/deepin/deepin-terminal/config.conf
    log 1 "4.7 坚果云"
    sudo pacman -S gvfs python-notify2 jdk8-openjdk --needed
    wget http://www.jianguoyun.com/static/exe/installer/nutstore_linux_dist_x64.tar.gz -O /tmp/nutstore_bin.tar.gz
    mkdir -p ~/.nutstore/dist && tar zxf /tmp/nutstore_bin.tar.gz -C ~/.nutstore/dist
    ~/.nutstore/dist/bin/install_core.sh
    sed -i "s/env python/env python2/g" "${HOME}"/.nutstore/dist/bin/nutstore-pydaemon.py
    sed -i "s/enterprise=false/enterprise=true/g" "${HOME}"/.nutstore/dist/conf/nutstore.properties
    log 1 "4.8 StarUML"
    sudo sed -i '/var pk, decrypted/a\        return {\n            name: "0xcc",\n            product: "StarUML",\n            licenseType: "vip",\n            quantity: "www.qq.com",\n            licenseKey: "later equals never!"\n        };' /opt/staruml/www/license/node/LicenseManagerDomain.js
}

function extra_config() {
    log 0 "5. 其他配置"
    log 1 "5.1 控制中心相关设置"
    press_any_key_to_continue '1. 更换头像\n2. 亮度中开启"自动调节色温" \n3. 默认程序 \n4. 标准字体修改为"Noto Sans CJK SC"，等宽字体修改为"Fira Code" \n5. 更换图标主题 \n6. 关闭音效 \n7. 开启时间"自动同步" \n8. 开启"插入鼠标禁用触摸板"'
    log 1 "5.2 其他软件设置"
    press_any_key_to_continue '1. fcitx\n2. albert \n3. notepadqq \n4. Android Studio \n5. Zeal \n6. StarUML'
}

function main() {
    restore_official_packages
    base_env_config
    restore_extra_packages
    software_config
    extra_config
}

main
