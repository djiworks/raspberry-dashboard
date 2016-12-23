#!/bin/bash
sudo apt-get update  
sudo apt-get upgrade
sudo apt-get install libssl-dev
sudo apt-get install bundler
sudo gem install dashing
cd /path/to/create
sudo dashing new dashboard
cd dashboard
bundle
dashing start

# Use pm2 to monit
sudo mv . /var/www/
pm2 start dashing --name dashboard-server --interpreter ruby -- start


# make it as kiosk
sudo apt-get install chromium-browser
export DISPLAY=:0
chromium-browser --kiosk --ignore-certificate-errors --disable-sync --disable-restore-session-state http://127.0.0.1:3030

# make kiosk as a service
nano dashboard.sh
# export DISPLAY=:0
#chromium-browser --kiosk --ignore-certificate-errors --disable-sync --disable-restore-session-state http://127.0.0.1:3030
chmod +x dashboard.sh
pm2 start dashboard.sh --name dashboard-display