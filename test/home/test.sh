#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "Fedora OS Release" [ $(cat /etc/os-release | grep "ID=fedora") ]
check "DOCKER_HOST is set" [ "$(env | grep DOCKER_HOST)" ]
# Core Template local-feature defaults
check "DNF Available" [ "$(dnf --version)" ]
check "DNF Package Installation succeed(run which git...)" [ $(which git) ]
check "Created Userhome" [ $(cat /etc/passwd | grep "/home/") ]
# Working localy so may return here if there problems
check "Setup Brew" [ $(su -c "which brew") ]
check "User $(ls /home/) is in sudoers files" [ "$(ls /etc/sudoers.d/)" ]
check "User $(ls /etc/sudoers.d/) owns home" [ $(cat /etc/passwd | grep "$(ls /home/)") ]
# Report result
reportResults
