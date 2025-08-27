#!/data/data/com.termux/files/usr/bin/bash
# Script instalasi Go untuk Termux melalui paket resmi

# Update package manager
pkg update -y && pkg upgrade -y

# Install Go dari repositori Termux
pkg install golang -y

# Setup environment variables
cat >> ~/.bashrc << 'EOF'
# Go configuration
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
EOF

# Load environment seketika
source ~/.bashrc

# Verifikasi instalasi
echo "Versi Go terinstall:"
go version
