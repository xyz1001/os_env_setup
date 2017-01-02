# Lua 开发环境安装(以lua5.3为例)
- ## 二进制安装
- Debian系（Debian/Ubuntu/Deepin等）

`sudo apt install liblua5.3-dev`

- ## 源码编译安装

    由于依赖问题，在某些系统上可能无法通过包管理器直接安装，需要自行编译

1. 下载源码

    [下载地址](http://www.lua.org/ftp/lua-5.3.3.tar.gz)

    `wget http://www.lua.org/ftp/lua-5.3.3.tar.gz`

    `tar xvf lua-5.3.3.tar.gz`

2. 安装依赖

    避免在编译过程中遇到`error: readline/readline.h: No such file or directory`问题。
    
    `sudo apt install libreadline-dev`

    若因依赖冲突导致安装失败可编译安装，具体查看[readline安装](../readline/readline.md)

3. 编译

    `cd lua-5.3.3`
    
    `make linux`
    
    `sudo make install`
