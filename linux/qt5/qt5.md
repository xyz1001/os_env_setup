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

- **支持fcitx输入中文**
> 1. 下载[fcitx-qt5](https://github.com/fcitx/fcitx-qt5)
> 2. 安装编译依赖
```
sudo apt install extra-cmake-modules libxkbcommon-dev fcitx-libs-dev bison libgl1-mesa-dev libglu1-mesa-dev
```
> 3. 导入环境变量
```
export PATH=${your Qt dir}/${Qt Version}/gcc_64/bin:$PATH
```
注意：此处需要导入Qt完整安装包安装路径的`bin`目录，否则编译时会提示`Parse error at "IID"`错误
> 3. 编译
```
cmake . && make
```
> 4. 添加运行库
将生成的`platforminputcontext/libfcitxplatforminputcontextplugin.so`文件复制至Qt Creator的`plugins/platforminputcontexts/`文件夹，确保`.so`文件有可执行权限
**`gcc_64_Qt5.8`编译的文件以上传至微云`软件/Linux/fcitx-qt5`**
