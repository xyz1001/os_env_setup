#!/usr/bin/env bash

sudo sed -i "s/socks4\s*127.0.0.1\s*9050/socks5 \t127.0.0.1 1080/g" /etc/proxychains.conf
