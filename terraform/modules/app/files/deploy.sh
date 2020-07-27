#!/bin/bash
set -e

APP_DIR=$HOME/reddit
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR
cd $APP_DIR && bundle install

PUMA_TMP_PATH=$1
echo $PUMA_TMP_PATH

sudo mv $PUMA_TMP_PATH /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
