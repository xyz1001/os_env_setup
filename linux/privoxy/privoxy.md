# privoxy

## 配置
将`http`请求转发至shadowsocks的`socks5`
1. `vim /etc/privoxy/config`
2. 在最后一行添加`forward-socks5 / 127.0.0.1:1080 .`
3. `sudo service privoxy start`
4. HTTP代理地址是`127.0.0.1:8118`
