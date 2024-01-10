#/bin/sh

opkg install curl tar
curl -s -L https://github.com/Skrill0/XKeen/releases/latest/download/xkeen.tar --output xkeen.tar && tar -xvf xkeen.tar -C /opt/sbin --overwrite > /dev/null && rm xkeen.tar
xkeen -i
