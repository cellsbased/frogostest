# FrogOS Packages and Applications

This document provides a comprehensive list of all packages and applications included in FrogOS, along with their functions and purposes.

## Core System Components

### Window Manager & Compositor
- **hyprland** - Dynamic tiling Wayland compositor (main window manager)
- **hypridle** - Idle daemon for Hyprland
- **hyprlock** - Screen lock utility for Hyprland
- **hyprpicker** - Color picker for Hyprland
- **hyprshot** - Screenshot utility for Hyprland
- **hyprsunset** - Automatic night light for Hyprland
- **hyprland-qtutils** - Qt utilities for Hyprland

### Display & Graphics
- **swaybg** - Wallpaper daemon for Wayland (fallback)
- **swww** - Simple Wayland Wallpaper (animated wallpapers with transitions, loops normally)
- **swayosd** - On-screen display for volume/brightness
- **wl-screenrec** - Screen recording for Wayland
- **wf-recorder** - Screen recording utility
- **slurp** - Interactive region selection for Wayland
- **imv** - Image viewer for Wayland
- **satty** - Screenshot annotation tool

### Audio & Media
- **mpv** - Media player
- **moc** - Music on Console (TUI audio player)
- **cava** - Cross-platform Audio Visualizer (terminal-based)
- **playerctl** - Media player control
- **pamixer** - PulseAudio mixer
- **wireplumber** - Audio session manager
- **wiremix** - Audio mixer interface

### Terminal & Shell
- **alacritty** - GPU-accelerated terminal emulator
- **yazi** - Blazing fast terminal file manager (Rust-based)
- **bash-completion** - Bash command completion
- **starship** - Cross-shell prompt
- **zoxide** - Smart directory navigation
- **fzf** - Fuzzy finder
- **ripgrep** - Fast text search
- **fd** - Simple alternative to find
- **bat** - Cat clone with syntax highlighting
- **eza** - Modern ls replacement
- **dust** - Disk usage analyzer
- **btop** - System monitor
- **less** - Pager utility
- **man** - Manual pages
- **nano** - Simple text editor

### File Management
- **tree-sitter-cli** - Tree-sitter CLI
- **unzip** - Archive extraction
- **plocate** - Fast file locator

### Development Tools
- **nvim** - Neovim text editor
- **frogos-lazyvim** - Pre-configured Neovim setup
- **cargo** - Rust package manager
- **clang** - C/C++ compiler
- **llvm** - Compiler infrastructure
- **mise** - Development environment manager
- **lazygit** - Git interface
- **lazydocker** - Docker interface
- **github-cli** - GitHub command line tool
- **luarocks** - Lua package manager
- **python-gobject** - Python GObject bindings
- **python-poetry-core** - Python dependency management
- **python-terminaltexteffects** - Terminal text effects

### Programming Languages & Libraries
- **libyaml** - YAML parsing library
- **libqalculate** - Calculator library
- **mariadb-libs** - MariaDB client libraries
- **postgresql-libs** - PostgreSQL client libraries

### Web & Communication
- **librewolf** - Privacy-focused web browser
- **frogos-chromium** - Custom Chromium build
- **signal-desktop** - Signal messaging app
- **spotify** - Music streaming service
- **localsend** - File sharing utility

### Office & Productivity
- **libreoffice** - Office suite
- **zettlr** - Academic writing tool
- **gnome-calculator** - Calculator application
- **pinta** - Image editor
- **tododo** - TUI todo manager (markdown-based)
- **caps-log** - TUI journaling tool (markdown-based)

### System Utilities
- **system-config-printer** - Printer configuration
- **cups** - Printing system
- **cups-browsed** - CUPS network browsing
- **cups-filters** - CUPS filters
- **cups-pdf** - PDF printing support
- **avahi** - Network service discovery
- **nss-mdns** - Multicast DNS name resolution
- **inetutils** - Network utilities
- **whois** - Domain information lookup
- **tzupdate** - Timezone updater
- **ufw** - Uncomplicated firewall
- **ufw-docker** - Docker UFW integration

### Hardware & Drivers
- **iwd** - Wireless daemon
- **wireless-regdb** - Wireless regulatory database
- **brightnessctl** - Brightness control
- **power-profiles-daemon** - Power management
- **blueberry** - Bluetooth manager

### Input & Internationalization
- **fcitx5** - Input method framework
- **fcitx5-gtk** - Fcitx5 GTK support
- **fcitx5-qt** - Fcitx5 Qt support

### Fonts & Typography
- **noto-fonts** - Google Noto fonts
- **noto-fonts-cjk** - Noto fonts for CJK languages
- **noto-fonts-emoji** - Noto emoji fonts
- **noto-fonts-extra** - Additional Noto fonts
- **ttf-cascadia-mono-nerd** - Cascadia Code with Nerd Fonts
- **ttf-ia-writer** - IA Writer fonts
- **ttf-jetbrains-mono-nerd** - JetBrains Mono with Nerd Fonts
- **woff2-font-awesome** - Font Awesome icons
- **fontconfig** - Font configuration library

### Desktop Integration
- **xdg-desktop-portal-gtk** - Desktop portal for GTK
- **xdg-desktop-portal-hyprland** - Desktop portal for Hyprland
- **polkit-gnome** - PolicyKit authentication agent
- **gnome-keyring** - Password and key management
- **gnome-themes-extra** - Additional GNOME themes
- **yaru-icon-theme** - Yaru icon theme

### Wayland & Display
- **qt5-wayland** - Qt5 Wayland support
- **wl-clipboard** - Wayland clipboard utilities
- **wl-clip-persist** - Persistent clipboard for Wayland

### System Monitoring & Management
- **uwsm** - User Wayland session manager
- **walker-bin** - Application launcher
- **waybar** - Status bar for Wayland
- **mako** - Notification daemon
- **plymouth** - Boot splash screen
- **wtfutil** - Personal information dashboard

### Media & Graphics
- **imagemagick** - Image manipulation
- **ffmpegthumbnailer** - Video thumbnail generation
- **obs-studio** - Screen recording and streaming
- **kdenlive** - Video editor

### Development & Build Tools
- **yay** - AUR helper
- **tldr** - Simplified man pages
- **xmlstarlet** - XML command line toolkit
- **gum** - Glamorous shell scripts

### Additional Applications

#### Hidden Applications (Available but not shown in main menu)
- **avahi-discover** - Network service discovery
- **bssh** - Bluetooth SSH
- **btop** - System monitor
- **bvnc** - Bluetooth VNC
- **cmake-gui** - CMake GUI
- **cups** - Printer management
- **dropbox** - File synchronization
- **electron34** - Electron runtime
- **fcitx5-configtool** - Input method configuration
- **kbd-layout-viewer5** - Keyboard layout viewer
- **kcm_fcitx5** - KDE Fcitx5 module
- **kcm_kaccounts** - KDE accounts module
- **kvantummanager** - Qt theme manager
- **org.fcitx.fcitx5-*** - Fcitx5 components
- **qv4l2** - Video4Linux2 control
- **qvidcap** - Video capture
- **uuctl** - USB control
- **xgps** - GPS viewer
- **xgpsspeed** - GPS speed viewer

#### Desktop Applications
- **imv.desktop** - Image viewer
- **mpv.desktop** - Media player
- **nvim.desktop** - Neovim editor
- **zettlr.desktop** - Academic writing tool

### Web Applications (Available via FrogOS Menu)
- **ChatGPT** - AI assistant
- **Discord** - Voice and text chat
- **Figma** - Design tool
- **GitHub** - Code repository
- **Google Contacts** - Contact management
- **Google Messages** - Messaging
- **Google Photos** - Photo storage
- **HEY** - Email service
- **WhatsApp** - Messaging
- **X (Twitter)** - Social media
- **YouTube** - Video platform
- **Zoom** - Video conferencing

## Package Management

FrogOS uses the following package managers:
- **pacman** - Main package manager
- **yay** - AUR helper for community packages
- **mise** - Development environment management

## Custom FrogOS Packages

- **frogos-chromium** - Custom Chromium build with FrogOS optimizations
- **frogos-lazyvim** - Pre-configured Neovim setup for FrogOS

### Todo Management Tools
- **frogos-todo** - TUI todo manager wrapper (launches tododo)
- **tododo** - Markdown-based TUI todo manager

### Journaling Tools
- **frogos-journal** - TUI journaling wrapper (launches caps-log)
- **caps-log** - TUI journaling tool (markdown-based with calendar view)

### Music Management Tools
- **frogos-music** - TUI music player wrapper (launches MOC)
- **moc** - Music on Console (TUI audio player)

### Audio Visualization Tools
- **frogos-visualizer** - Audio visualizer wrapper (launches CAVA)
- **cava** - Cross-platform Audio Visualizer (terminal-based)

### File Management Tools
- **frogos-files** - File manager wrapper (launches Yazi)
- **yazi** - Blazing fast terminal file manager (Rust-based) - Replaces Nautilus

### Weather Tools
- **frogos-weather** - Weather information (wttr.in integration)
- **frogos-weather-advanced** - Advanced weather options

## System Architecture

FrogOS is built on:
- **Arch Linux** - Base operating system
- **Hyprland** - Wayland compositor and window manager
- **Wayland** - Display server protocol
- **systemd** - System and service manager
- **Plymouth** - Boot splash screen

This comprehensive package selection provides a complete development and productivity environment with modern tools and applications optimized for the Wayland ecosystem.
