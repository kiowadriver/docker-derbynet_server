#! /bin/bash

# items in the boot folder take priority. Copy all config files over so they can be saved/shared
# -n = only copy if the file doesn't already exist
cp -n /etc/derbynet*.conf /boot/



