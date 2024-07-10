#!/bin/bash

# Đặt kích thước swap mới (MB)
SWAP_SIZE_MB=20000

# Tên file swap
SWAP_FILE="/swapfile"

# Tắt swap hiện tại
sudo swapoff -a

# Xóa file swap hiện tại
sudo rm -f $SWAP_FILE

# Tạo file swap mới với kích thước mong muốn
sudo fallocate -l ${SWAP_SIZE_MB}M $SWAP_FILE

# Thiết lập quyền cho file swap
sudo chmod 600 $SWAP_FILE

# Tạo swap từ file swap mới
sudo mkswap $SWAP_FILE

# Bật lại swap
sudo swapon $SWAP_FILE

# Kiểm tra swap đã được kích hoạt
sudo swapon --show

# Cập nhật fstab để swap tự động kích hoạt khi khởi động lại
grep -q "swapfile" /etc/fstab || echo "$SWAP_FILE none swap sw 0 0" | sudo tee -a /etc/fstab

echo "Swap đã được thay đổi thành ${SWAP_SIZE_MB}MB."
