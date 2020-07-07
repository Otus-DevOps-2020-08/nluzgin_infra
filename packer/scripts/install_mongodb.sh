#!/bin/bash

#set repo mongodb
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D68FA50FEA312927
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

#install mongodb
apt update
apt install -y mongodb-org

#enable and start mongodb
systemctl enable mongod
systemctl start mongod
