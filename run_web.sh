#!/bin/bash

API_KEY=$(grep MAP_API_KEY .env | cut -d '=' -f2 | xargs)

sed "s/%MAP_API_KEY%/$API_KEY/g" web/index.html > web/index.html.tmp
mv web/index.html.tmp web/index.html

flutter run -t lib/main_dev.dart -d chrome