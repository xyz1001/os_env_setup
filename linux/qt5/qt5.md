#Qt5

## 开发环境搭建
1. 执行以下命令安装相关开发库和工具
`sudo apt install qt5-qmake libqt5core5a qttools5-dev-tools libqtwebkit-dev qt5-default gdb gcc g++`
2. 官网下载`Qt Creator`，以`root`权限安装至`/opt`目录。
3. 在`Qt Creator`中配置`Debuggers`，`编译器`，`Qt Versions`和`构建套件`

## 配置
- **修改qtchooser默认Qt版本**
> 安装`qt5-default`或执行以下命令:
 - `sudo rm -rf /usr/lib/x86_64-linux-gnu/qt-default/qtchooser/default.conf`
 - `sudo ln -s /usr/share/qtchooser/qt5-x86_64-linux-gnu.conf /usr/lib/x86_64-linux-gnu/qt-default/qtchooser/default.conf`
