# Simple dashboard for Raspberry

![Dashboard example](https://github.com/djiworks/raspberry-dashboard/blob/master/screenshot.png)

## Prerequisite
- Ruby 1.9+
- gem

## Step 1: Make your dashboard
### Installing Dashing
```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install libssl-dev
sudo apt-get install bundler
sudo gem install dashing
```

### Create your dashboard
Go to directory where you want to create your dashboard files. Usually, we use `/var/www`.

Then run `dashing new DASHBOARDNAME`, replacing DASHBOARDNAME by the name you want.

Finally, go to the new DASHBOARDNAME directory and run `bundle`.

That's all !! You can start your dashboard using `dashing start`and visit it from a browser on `http://RPI_IP:3030`.
RPI_IP should be replaced by the IP your raspberry uses.

## Step 2: Make your widget

## Step 3: Make your Raspberry as a kiosk display
First install chromium `apt-get install chromium-browser`
Then create a script `nano display_dashboard.sh` containing
```bash
export DISPLAY=:0 # To be able to run a GUI software when using the terminal
chromium-browser --kiosk --incognito http://127.0.0.1:3030
```
Finally add execution right running `chmod +x display_dashboard.sh`
## Sources
[Dashing.io] (http://dashing.io/)
