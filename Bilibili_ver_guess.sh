#!/bin/bash

# Type the info
version="8.11.0"  # version you want
sn=15828351       # start sn

while true; do
    url="https://dl.hdslb.com/mobile/pack/android64/$sn/iBiliPlayer-apinkRelease-$version-b$sn.apk"
    wget -q $url -O iBiliPlayer-$sn.apk
    if [ $? -eq 0 ]; then
        echo "下载成功: $url"
        break
    else
        echo "服务器上没有sn为$sn的文件"
        rm -f iBiliPlayer-$sn.apk
    fi
    sn=$((sn + 1))
done
