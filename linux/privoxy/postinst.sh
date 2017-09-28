#!/usr/bin/env bash

sudo sh -c 'echo "forward-socks5 / 127.0.0.1:1080 ." >> /etc/privoxy/config'

type service > /dev/null 2>&1
if [ $? == 0 ]; then
    sudo service privoxy start
    exit
fi

type systemctl > /dev/null 2>&1
if [[ $? == 0 ]]; then
    sudo systemctl enable privoxy
    sudo systemctl start privoxy
    exit
fi
