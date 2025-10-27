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

# ✅ Xoá tất cả các dòng add_list ntp cũ
sed -i "/add_list system\.ntp\.server=/d" "$CFG_FILE"

# ✅ Thêm các dòng add_list mới sau dòng set system.ntp.enable_server='0'
sed -i "/set system\.ntp\.enable_server='0'/a \
add_list system.ntp.server='vn.pool.ntp.org'\n\
add_list system.ntp.server='time.google.com'\n\
add_list system.ntp.server='time.cloudflare.com'\n\
add_list system.ntp.server='time.apple.com'" "$CFG_FILE"

echo "✅ Đã sửa $CFG_FILE đúng yêu cầu"

# ✅ Thêm config uhttpd mặc định 8080/8443
UHTTPD_CFG="package/network/services/uhttpd/files/uhttpd.config"
if [ -f "$UHTTPD_CFG" ]; then
  sed -i 's/option listen_http.*/option listen_http '\''0.0.0.0:8080'\''/' "$UHTTPD_CFG"
  sed -i 's/option listen_https.*/option listen_https '\''0.0.0.0:8443'\''/' "$UHTTPD_CFG"
  sed -i '/redirect_https/d' "$UHTTPD_CFG"
  echo "option redirect_https '0'" >>"$UHTTPD_CFG"
  echo "✅ Đã chỉnh uhttpd.config sang 8080/8443"
else
  echo "⚠️ Không tìm thấy $UHTTPD_CFG, bỏ qua."
fi
