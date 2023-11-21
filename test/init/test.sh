#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "os-release is Fedora" [ $(cat /etc/os-release | grep "ID=fedora") ]
check "Can use DNF to install packages" [ $(which dnf) ]
check "Create user correct" [ $(cat /etc/passwd | grep "coffe:x:1000:1000") ]

# Report result
reportResults