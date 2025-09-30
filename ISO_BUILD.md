# Building a FrogOS ISO

This guide explains how to create a bootable FrogOS ISO image for installation.

## Prerequisites

You need an Arch Linux system with `archiso` installed:

```bash
sudo pacman -S archiso
```

## Quick Start

Run the FrogOS ISO builder script:

```bash
sudo ./build-iso.sh
```

The ISO will be created in `~/frogos-iso/out/`

## Manual Build Process

### 1. Set Up Build Environment

```bash
# Create build directory
mkdir -p ~/frogos-iso
cd ~/frogos-iso

# Copy the releng profile as a base
cp -r /usr/share/archiso/configs/releng/ .

# Or copy the baseline profile for minimal ISO
# cp -r /usr/share/archiso/configs/baseline/ .
```

### 2. Configure Packages

Edit `packages.x86_64` to include FrogOS packages:

```bash
# Copy FrogOS package list
cat /path/to/frogos/install/frogos-base.packages >> releng/packages.x86_64
cat /path/to/frogos/install/frogos-other.packages >> releng/packages.x86_64
```

### 3. Add FrogOS Files

Copy FrogOS configuration to the ISO:

```bash
# Create FrogOS directory in the ISO
mkdir -p releng/airootfs/usr/share/frogos

# Copy all FrogOS files
cp -r /path/to/frogos/* releng/airootfs/usr/share/frogos/

# Set up automatic installation script
mkdir -p releng/airootfs/etc/skel
cat > releng/airootfs/etc/skel/.bash_profile << 'EOF'
# Auto-start FrogOS installer on first login
if [[ -f /usr/share/frogos/install.sh ]] && [[ ! -f ~/.frogos-installed ]]; then
    bash /usr/share/frogos/install.sh
    touch ~/.frogos-installed
fi
EOF
```

### 4. Customize ISO

Edit `releng/profiledef.sh` to customize ISO name and settings:

```bash
#!/usr/bin/env bash
iso_name="frogos"
iso_label="FROGOS_$(date +%Y%m)"
iso_publisher="FrogOS <https://frogos.org>"
iso_application="FrogOS Live/Rescue CD"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=()
```

### 5. Add Boot Splash

Copy FrogOS branding:

```bash
# Copy Plymouth theme
mkdir -p releng/airootfs/usr/share/plymouth/themes/frogos
cp /path/to/frogos/default/plymouth/* releng/airootfs/usr/share/plymouth/themes/frogos/

# Copy FrogOS logo
cp /path/to/frogos/logo.png releng/airootfs/usr/share/pixmaps/frogos-logo.png
```

### 6. Build the ISO

```bash
cd releng
sudo mkarchiso -v -w /tmp/archiso-tmp .
```

The ISO will be created in `releng/out/frogos-YYYY.MM.DD-x86_64.iso`

### 7. Test the ISO

Test in QEMU:

```bash
qemu-system-x86_64 \
    -cdrom releng/out/frogos-*.iso \
    -m 4G \
    -enable-kvm \
    -boot d
```

## Writing ISO to USB

### Linux

```bash
sudo dd bs=4M if=frogos-*.iso of=/dev/sdX status=progress oflag=sync
```

Replace `/dev/sdX` with your USB device (check with `lsblk`).

### macOS

```bash
sudo dd bs=4m if=frogos-*.iso of=/dev/diskX
```

Replace `/dev/diskX` with your USB device (check with `diskutil list`).

### Windows

Use [Rufus](https://rufus.ie/) or [balenaEtcher](https://www.balena.io/etcher/).

## Advanced Customization

### Adding Default User

Create a default user that auto-logs in:

```bash
# Edit airootfs/etc/passwd to add user
# Edit airootfs/etc/shadow for password
# Configure autologin in getty service
```

### Custom Repositories

Add AUR or custom repositories in `releng/pacman.conf`:

```ini
[frogos]
Server = https://mirror.frogos.org/$repo/os/$arch
```

### Pre-installing AUR Packages

Build AUR packages and add them to a custom repository, or include build scripts in the ISO.

## Troubleshooting

### Build Fails

- Ensure all packages in `packages.x86_64` are available
- Check pacman mirrors are accessible
- Verify sufficient disk space (need ~10GB)

### ISO Won't Boot

- Verify UEFI/BIOS settings
- Try different bootmodes in `profiledef.sh`
- Check ISO integrity with `sha256sum`

### Packages Missing in Live Environment

- Add missing packages to `packages.x86_64`
- Rebuild the ISO

## Resources

- [Arch ISO Documentation](https://wiki.archlinux.org/title/Archiso)
- [FrogOS GitHub](https://github.com/basecamp/frogos)
- [FrogOS Manual](https://manuals.frogos.org)

## Notes

- The ISO includes all FrogOS packages but doesn't install them automatically
- Users boot into a live environment and run the installer
- The installer is located at `/usr/share/frogos/install.sh`
- Or use the online installer: `curl -sSL https://boot.frogos.org | bash`
