#!/bin/bash

# Initialize variables
version="8.11.0"  # version you need
sn_start=15828360  # starting sn
batch_size=100      # number of sn per batch

while true; do
    # Generate a batch of sn
    seq $sn_start $((sn_start + batch_size - 1)) | xargs -P $batch_size -I {} bash -c '
        sn={}
        url="https://dl.hdslb.com/mobile/pack/android64/$sn/iBiliPlayer-apinkRelease-'$version'-b$sn.apk"
        
        wget -q $url -O iBiliPlayer-$sn.apk
        if [ $? -eq 0 ]; then
            echo "下载成功: $url"
            exit 0  # break
        else
            echo "服务器上没有sn为$sn的文件"
            rm -f iBiliPlayer-$sn.apk
        fi
    '
    
    # check if success
    if ls iBiliPlayer-*.apk 1> /dev/null 2>&1; then
        echo "下载成功，任务完成。"
        break
    fi
    
    # Increase the range of sn
    sn_start=$((sn_start + batch_size))
done
