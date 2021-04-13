# This script will install Docker/Docker-compose/git on alpine38

#!/bin/sh

set -e

# Install pip and other dependencies
apk update
apk add python3 libffi-dev openssl-dev gcc libc-dev make git
apk add py3-pip

# Install/Config docker
sed -i 's/quiet/quiet cgroup_enable=memory swapaccount=1/' /boot/extlinux.conf
apk add docker

# Setup users privileges to run docker properly
memb=$(grep "^docker:" /etc/group | sed -e 's/^.*:\([^:]*\)$/\1/g')
[ "${memb}x" = "x" ] && memb=${USER} || memb="${memb},${USER}"
memb="${memb},vagrant"
sed -e "s/^docker:\(.*\):\([^:]*\)$/docker:\1:${memb}/g" -i /etc/group

# Make docker run at start
service docker start
rc-update add docker

# Install docker-compose
pip3 install 'docker-compose==1.8.0'

# Install docker-bash-completion
apk add docker-bash-completion
