# Krita

## 简介
    Krita是一个免费、开源的专业绘画软件。

## 安装

1. 下载

    [下载页面](https://krita.org/zh/download-zh/krita-desktop-zh/)

    [Krita3.1.1 amd64](http://download.kde.org/stable/krita/3.1.1/krita-3.1.1-x86_64.appimage)

    为krita AppImage文件添加执行权限

    `chmod a+x ./文件名`

2. 创建Desktop Entry及图标

    [Desktop Entry](./krita.desktop)

    [图标](./krita.png)

    修改Desktop Entry文件中krita启动命令

    移动至启动器文件夹

    `cp krita.desktop ~/.local/share/applications/`

    `cp krita.png ~/.local/share/icons/hicolor/256x256/apps`
