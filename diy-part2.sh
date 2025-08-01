#!/bin/bash
#
# File: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Áp dụng cho repo: https://github.com/padavanonly/immortalwrt-mt798x-6.6
#

# ✅ Thay đổi IP mặc định nếu cần
# Ví dụ: đổi từ 192.168.1.1 → 192.168.50.5
# sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# ✅ Đổi theme mặc định sang luci-theme-argon nếu có
# if grep -q "luci-theme-argon" feeds/luci/collections/luci/Makefile; then
#     sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
# fi

# ✅ Đổi hostname thiết bị (hiển thị trong Luci)
# sed -i 's/OpenWrt/ImmortalWRT/g' package/base-files/files/bin/config_generate

# ✅ Thêm theme hoặc app tùy chọn nếu chưa có
# Ví dụ clone theme argon
# [ ! -d "package/lean/luci-theme-argon" ] && git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon package/lean/luci-theme-argon

# ✅ Thêm plugin tự chọn (nếu cần)
# git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns

# ✅ Cập nhật timestamp build (hiển thị trên Luci hoặc firmware)
BUILD_DATE=$(date +"%Y-%m-%d %H:%M")
echo "Build date: $BUILD_DATE"

