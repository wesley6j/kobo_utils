#!/bin/sh

set -e

scp ./src/device.lua kobo:/tmp/

scp ./dist/pageturn kobo:/tmp/

ssh kobo "mv /tmp/pageturn /usr/bin/"

ssh kobo "mv /tmp/device.lua /mnt/onboard/.adds/koreader/frontend/device/kobo/"
