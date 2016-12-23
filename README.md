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

If you want to customize or create new dashboard page:
- Create a my_dashboard.erb file in DASHBOARDNAME/dashboards
- Write inside:
```html
<% content_for :title do %>Raspberry Dashboard<% end %>
<div class="gridster">
  <ul>
    <li data-row="0" data-col="1" data-sizex="1" data-sizey="1">
      <div data-view="Clock"></div>
      <i class="fa fa-clock-o icon-background"></i>
    </li>
  </ul>
</div>
```
- See it visiting `http://RPI_IP:3030/my_dashboard`
- Make it as default dashboard (the one displayed on the root url). To do that, simply add this line
`set :default_dashboard, 'my_dashboard'` in `DASHBOARDNAME/config.ru` after `set :auth_token, 'aToken'`

## Step 2: Make your own widgets
### Server Status
Tile to display ping or http get request on an url.
Based on https://gist.github.com/willjohnson/6313986. Please see modifications [here](https://gist.github.com/djiworks/c18650c662a993fcd1e9323afd87ccc3/revisions)




## Step 3: Make your Raspberry as a kiosk display
First install chromium `apt-get install chromium-browser`.

Then create a script `nano display_dashboard.sh` containing
```bash
export DISPLAY=:0 # To be able to run a GUI software when using the terminal
chromium-browser --kiosk --incognito http://127.0.0.1:3030
```
Finally add execution right running `chmod +x display_dashboard.sh`

## Step 4 (optionnal): Use dashboard backend and kiosk as service with pm2
- Install pm2: `npm install -g pm2`
- Go to your dashboard directoty (where DASHBOARDNAME is installed) and run:

`pm2 start dashing --name dashboard-server --interpreter ruby -- start`

- Go where your display_dashboard.sh is and run again:

`pm2 start dashboard.sh --name dashboard-display`

pm2 will then allow you to monitor the dashboard display and backend separately.
## Sources
- [Dashing.io] (http://dashing.io/)
- [PM2] (http://pm2.keymetrics.io/docs/usage/cluster-mode/)
- [Performance dashboard] (https://github.com/Clevero/dashing-performance-monitor)
- [Server Status] (https://gist.github.com/willjohnson/6313986)
