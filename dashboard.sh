#!/bin/bash
export DISPLAY=:0
chromium-browser --kiosk --incognito http://127.0.0.1:3030/main
