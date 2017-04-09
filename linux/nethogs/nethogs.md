# nethogs
[软件主页](https://github.com/raboof/nethogs)

## 安装
`sudo apt install nethogs`

## 配置
### 以非root权限运行
- `sudo setcap "cap_net_admin,cap_net_raw+pe" /usr/local/sbin/nethogs`
- `cp -s /usr/sbin/nethogs /usr/local/bin/`
