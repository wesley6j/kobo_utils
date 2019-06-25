#!/bin/busybox sh

wget -qO- http://192.168.2.100:9999/screen.png | fbink -g file=-,w=-1 -c
echo "OK"
