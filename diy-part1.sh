#!/bin/bash
#
# https://github.com/padavanonly/immortalwrt-mt798x-6.6
# File: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Chỉ thêm feed nếu chưa tồn tại để tránh trùng lặp

add_feed_if_not_exists() {
    local feed_name="$1"
    local feed_url="$2"
    if ! grep -q "$feed_url" feeds.conf.default; then
        echo "src-git $feed_name $feed_url" >> feeds.conf.default
    fi
}

# Ví dụ: bật lại feed helloworld nếu bị comment
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Nếu cần thêm feed riêng, thêm dòng sau:
# add_feed_if_not_exists <tên_feed> <url_feed>
