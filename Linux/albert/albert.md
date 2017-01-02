# albert安装及配置

albert是一个强大方便的启动器，支持软件启动，文件查找，网络搜索，书签搜索，系统操作调用，计算器，启动虚拟机和执行终端命令等功能

[官方主页](https://github.com/ManuelSchneid3r/albert)

## 安装

### deepin

1. 下载源码

    `git clone git@github.com:ManuelSchneid3r/albert.git`

2. 安装依赖

    `sudo apt-get install g++ cmake qtbase5-dev libqt5x11extras5-dev libqt5svg5-dev libqt5sql5-sqlite libmuparser-dev`

3. 编译安装

    `cd albert`

    `cmake . -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release`

    `make`

    `sudo make install`

4. BUG修复

- 安装后无法启动，提示`error while loading shared libraries:libalbertcore.so`
> 程序安装时未将`libalbertcore.so`复制到程序共享库目录，执行以下命令解决    
> `cp sudo cp ./lib/libalbertcore.so /usr/lib/albert`
