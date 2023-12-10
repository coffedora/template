#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "Fedora OS Release" [ $(cat /etc/os-release | grep "ID=fedora") ]
# Core Template local-feature defaults
check "DNF Available" [ "$(dnf --version)" ]
check "DNF Package Installation succeed(run which git...)" [ $(which git) ]
check "Create coffedora" [ $(cat /etc/passwd | grep coffedora) ]
check "Create home directory " [ "$(ls /home/coffedora/.local/)" ]
# Report result
reportResults
