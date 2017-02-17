#!/bin/bash

# Ensure we have KRAKEN_ENV set, default to development mode
# : ${APP_ENV?APP_ENV="development"}

if [ "$APP_ENV" != "production" ]; then
  hh_server /app &
fi


# Using NGINX

hhvm -m server -c /app/config/server.ini -c /app/config/${APP_ENV}.ini -p 9002 --admin-port=9001 -d hhvm.server.type=fastcgi -d pid="/tmp/hhvm-pid" &
nginx


# Using Proxygen

# hhvm -m server -c /app/config/server.ini -c /app/config/${APP_ENV}.ini -p 9000 --admin-port=9001
