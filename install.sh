#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define FrogOS locations
export FROGOS_PATH="$HOME/.local/share/frogos"
export FROGOS_INSTALL="$FROGOS_PATH/install"
export FROGOS_INSTALL_LOG_FILE="/var/log/frogos-install.log"
export PATH="$FROGOS_PATH/bin:$PATH"

# Install
source "$FROGOS_INSTALL/helpers/all.sh"
source "$FROGOS_INSTALL/preflight/all.sh"
source "$FROGOS_INSTALL/packaging/all.sh"
source "$FROGOS_INSTALL/config/all.sh"
source "$FROGOS_INSTALL/login/all.sh"
source "$FROGOS_INSTALL/post-install/all.sh"
