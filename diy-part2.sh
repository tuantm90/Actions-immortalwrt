#!/bin/bash
# Tự động sửa config_generate khi build ImmortalWrt

CFG_FILE="package/base-files/files/bin/config_generate"

[ -f "$CFG_FILE" ] || {
    echo "❌ Không tìm thấy file $CFG_FILE"
    exit 1
}

# ✅ Đổi IP mặc định thành 192.168.1.1
sed -i 's/ipad=\${ipaddr:-"[^"]*"}/ipad=${ipaddr:-"192.168.1.1"}/' "$CFG_FILE"

# ✅ Đổi hostname thành T-Wrt
sed -i "s/set system\.@system\[-1\]\.hostname='[^']*'/set system.@system[-1].hostname='T-Wrt'/" "$CFG_FILE"

# ✅ Đổi timezone thành Asia/Ho_Chi_Minh
sed -i "s/set system\.@system\[-1\]\.timezone='[^']*'/set system.@system[-1].timezone='Asia\/Ho_Chi_Minh'/" "$CFG_FILE"

# ✅ Đổi danh sách NTP server
# Xóa toàn bộ dòng add_list system.ntp.server hiện tại và thêm mới
sed -i "/add_list system.ntp.server/d" "$CFG_FILE"
sed -i "/set system.ntp.enable_server='0'/a \
add_list system.ntp.server='vn.pool.ntp.org'\n\
add_list system.ntp.server='time.google.com'\n\
add_list system.ntp.server='time.cloudflare.com'\n\
add_list system.ntp.server='time.apple.com'" "$CFG_FILE"

echo "✅ Đã sửa $CFG_FILE đúng yêu cầu"
