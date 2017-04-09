# vim
由于系统自带的`vim`一般未开启`python` `python3`等支持，故需要安装支持这些特性的vim版本

## 仓库安装
- `sudo apt purge vim`    #移除当前安装的`vim`
- `sudo apt install vim-gnome`

## 源码编译
[下载地址](ftp://ftp.vim.org/pub/vim/unix)
根据需要选择`enable`参数，需安装好特性支持的相关依赖，在`configure`输出中存在相关提示，一定要确认需要的特性在`configure`中开启成功
- `./configure --prefix=/usr/local --enable-cscope --enable-largefile --enable-multibyte --enable-python3interp=yes --enable-luainterp=yes --enable-pythoninterp=yes --enable-perlinterp=yes --enable-rubyinterp=yes --enable-gui=yes`
- `update-alternatives --install /usr/bin/vim vim /usr/local/bin/vim 110`
