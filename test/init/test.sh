#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "os-release is Fedora" [ $(cat /etc/os-release | grep "ID=fedora") ]
check "Can use $(which dnf)  to install packages" [ $(which dnf) ]  
# Working localy so may return here if there problems
check "Create user  $(cat /etc/passwd | grep "coffe")" [ $(cat /etc/passwd | grep "coffe") ]
# check "User is in sudoers files $(ls /etc/sudoers.d/ | grep "coffe")" [ $(ls /etc/sudoers.d/ | grep "coffe") ]
# Report result
reportResults