#!/bin/bash

# FrogOS ISO Builder
# Creates a bootable ISO with FrogOS pre-configured

set -e

echo "=== FrogOS ISO Builder ==="
echo ""

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

# Check if archiso is installed
if ! command -v mkarchiso &> /dev/null; then
    echo "Error: archiso is not installed"
    echo "Install it with: sudo pacman -S archiso"
    exit 1
fi

# Configuration
FROGOS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${BUILD_DIR:-$HOME/frogos-iso-build}"
ISO_NAME="${ISO_NAME:-frogos}"
ISO_VERSION="${ISO_VERSION:-$(date +%Y.%m.%d)}"

echo "Configuration:"
echo "  FrogOS Directory: $FROGOS_DIR"
echo "  Build Directory: $BUILD_DIR"
echo "  ISO Name: $ISO_NAME"
echo "  ISO Version: $ISO_VERSION"
echo ""

read -p "Continue with ISO build? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Build cancelled."
    exit 0
fi

# Clean previous build
if [[ -d "$BUILD_DIR" ]]; then
    echo "Cleaning previous build directory..."
    rm -rf "$BUILD_DIR"
fi

# Create build directory
echo "Setting up build environment..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Copy releng profile
echo "Copying archiso releng profile..."
cp -r /usr/share/archiso/configs/releng/* .

# Update ISO metadata
echo "Configuring ISO metadata..."
sed -i "s/iso_name=.*/iso_name=\"$ISO_NAME\"/" profiledef.sh
sed -i "s/iso_label=.*/iso_label=\"${ISO_NAME^^}_$(date +%Y%m)\"/" profiledef.sh
sed -i "s/iso_publisher=.*/iso_publisher=\"FrogOS <https:\/\/frogos.org>\"/" profiledef.sh
sed -i "s/iso_application=.*/iso_application=\"FrogOS Live\/Install CD\"/" profiledef.sh
sed -i "s/iso_version=.*/iso_version=\"$ISO_VERSION\"/" profiledef.sh

# Add FrogOS packages
echo "Adding FrogOS packages to ISO..."
cat "$FROGOS_DIR/install/frogos-base.packages" | grep -v '^#' | grep -v '^$' >> packages.x86_64
cat "$FROGOS_DIR/install/frogos-other.packages" | grep -v '^#' | grep -v '^$' >> packages.x86_64

# Remove duplicates and sort
sort -u packages.x86_64 -o packages.x86_64

# Copy FrogOS files to ISO
echo "Copying FrogOS files to ISO..."
mkdir -p airootfs/usr/share/frogos
cp -r "$FROGOS_DIR"/* airootfs/usr/share/frogos/

# Copy FrogOS binaries to PATH
mkdir -p airootfs/usr/local/bin
cp -r "$FROGOS_DIR"/bin/* airootfs/usr/local/bin/ 2>/dev/null || true

# Add FrogOS branding
echo "Adding FrogOS branding..."
mkdir -p airootfs/usr/share/pixmaps
cp "$FROGOS_DIR"/logo.png airootfs/usr/share/pixmaps/frogos-logo.png 2>/dev/null || echo "Logo not found, skipping..."
cp "$FROGOS_DIR"/icon.png airootfs/usr/share/pixmaps/frogos-icon.png 2>/dev/null || echo "Icon not found, skipping..."

# Copy Plymouth theme
mkdir -p airootfs/usr/share/plymouth/themes/frogos
cp "$FROGOS_DIR"/default/plymouth/* airootfs/usr/share/plymouth/themes/frogos/ 2>/dev/null || echo "Plymouth theme not found, skipping..."

# Create auto-installer script
echo "Setting up auto-installer..."
mkdir -p airootfs/etc/skel
cat > airootfs/etc/skel/.bash_profile << 'BASH_PROFILE'
# Auto-start FrogOS installer on first login (optional)
# Uncomment to enable automatic installation
# if [[ -f /usr/share/frogos/install.sh ]] && [[ ! -f ~/.frogos-installed ]]; then
#     echo "Starting FrogOS installation..."
#     bash /usr/share/frogos/install.sh
#     touch ~/.frogos-installed
# fi

# Show FrogOS welcome message
if [[ -f /usr/share/frogos/logo.txt ]]; then
    cat /usr/share/frogos/logo.txt
    echo ""
    echo "Welcome to FrogOS Live Environment!"
    echo ""
    echo "To install FrogOS, run: sudo /usr/share/frogos/install.sh"
    echo "Or use the online installer: curl -sSL https://boot.frogos.org | bash"
    echo ""
fi
BASH_PROFILE

# Create desktop launcher for installer
mkdir -p airootfs/usr/share/applications
cat > airootfs/usr/share/applications/frogos-installer.desktop << 'DESKTOP'
[Desktop Entry]
Type=Application
Name=Install FrogOS
Comment=Install FrogOS to your system
Icon=frogos-icon
Exec=alacritty -e sudo /usr/share/frogos/install.sh
Terminal=false
Categories=System;
DESKTOP

# Set proper permissions
echo "Setting file permissions..."
chmod +x airootfs/usr/share/frogos/install.sh 2>/dev/null || true
chmod +x airootfs/usr/share/frogos/boot.sh 2>/dev/null || true
chmod +x airootfs/usr/local/bin/* 2>/dev/null || true

# Build the ISO
echo ""
echo "Building ISO (this may take 10-30 minutes)..."
echo ""

mkarchiso -v -w /tmp/frogos-archiso-work .

# Check if build succeeded
if [[ -f "out/${ISO_NAME}-${ISO_VERSION}-x86_64.iso" ]]; then
    ISO_PATH="$BUILD_DIR/out/${ISO_NAME}-${ISO_VERSION}-x86_64.iso"
    ISO_SIZE=$(du -h "$ISO_PATH" | cut -f1)
    
    echo ""
    echo "========================================="
    echo "ISO Build Complete!"
    echo "========================================="
    echo ""
    echo "ISO Location: $ISO_PATH"
    echo "ISO Size: $ISO_SIZE"
    echo ""
    echo "To test the ISO in QEMU:"
    echo "  qemu-system-x86_64 -cdrom \"$ISO_PATH\" -m 4G -enable-kvm -boot d"
    echo ""
    echo "To write to USB (replace /dev/sdX with your USB device):"
    echo "  sudo dd bs=4M if=\"$ISO_PATH\" of=/dev/sdX status=progress oflag=sync"
    echo ""
    echo "Or use balenaEtcher: https://www.balena.io/etcher/"
    echo ""
else
    echo ""
    echo "========================================="
    echo "ISO Build Failed!"
    echo "========================================="
    echo ""
    echo "Check the build log above for errors."
    echo "Common issues:"
    echo "  - Missing packages in repositories"
    echo "  - Insufficient disk space"
    echo "  - Network connectivity issues"
    echo ""
    exit 1
fi
