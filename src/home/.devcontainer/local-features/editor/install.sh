#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
#
# ** This script is community supported **
# Docs: https://github.com/microsoft/vscode-dev-containers/blob/main/script-library/docs/common.md
# Maintainer: The VS Code and Codespaces Teams
#
# Syntax: ./common-redhat.sh [install zsh flag] [username] [user UID] [user GID] [upgrade packages flag] [install Oh My Zsh! flag]

set -e
if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
MARKER_FILE="/usr/local/etc/vscode-dev-containers/common"
FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f /etc/profile.d/00-restore-env.sh
echo "export PATH=${PATH//$(sh -lc 'echo $PATH')/\$PATH}" > /etc/profile.d/00-restore-env.sh
chmod +x /etc/profile.d/00-restore-env.sh


package_list="\
    nvim gh"
# Shim to use microdnf if available, otherwise lookup for dnf binary as it may be dnf5 or dnf7
# # Install dependencies and common used tool in devcontainer
if [ "${PACKAGES_ALREADY_INSTALLED}" != "true" ]; then
    # Check if dnf command will fail to create
    # Check if dnf command will fail to create symlink
    if ! dnf --version > /dev/null 2>&1; then
        ln -s $(ls /bin/dnf* | head -n 1) /bin/dnf
    fi
    PACKAGES_ALREADY_INSTALLED="true"
    #get the path of the installed user shell 
    USER_SHELL=$(which ${USER_SHELL})
fi
# Update to latest versions of packages
if [ "${UPGRADE_PACKAGES}" = "true" ]; then
    dnf upgrade -y
fi
# Ensure that login shells get the correct path if the user updated the PATH using ENV.

# code shim, it fallbacks to code-insiders if code is not available
cat << 'EOF' > /usr/local/bin/code
#!/bin/sh

get_in_path_except_current() {
    which -a "$1" | grep -A1 "$0" | grep -v "$0"
}
workpath="."
code="$(get_in_path_except_current code)"
if [ -n "$@" ]; then
    workpath=$@
fi
if [ -n "$code" ]; then
    exec "$code" "$workpath" 
elif [ "$(command -v code-insiders)" ]; then
    exec code-insiders "$workpath"
else
    echo "code or code-insiders is not installed" >&2
    exit 127
fi
EOF
chmod +x /usr/local/bin/code
)"

# Write marker file
mkdir -p "$(dirname "${MARKER_FILE}")"
echo -e "PACKAGES_ALREADY_INSTALLED=${PACKAGES_ALREADY_INSTALLED}\n"
echo "Done!"
dnf clean all
rm -rf /var/cache/dnf\ 
rm -rfd /tmp/*