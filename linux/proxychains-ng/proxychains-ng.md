# proxychains-ng

- [下载地址](https://github.com/rofl0r/proxychains-ng)

- 配置
> 复制项目文件夹下`src/proxychains.conf`至`/etc`，修改`socks4   127.0.0.1 9050`
> 为`socks5     127.0.0.1 1080`

- NOTE
1. 使用`-q`参数以安静模式启动`proxychains`，否则大量log输出会影响`vim`等正常使用。
