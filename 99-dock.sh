#!/bin/bash

IFACE="$1"
ACTION="$2"
### TARGET_USER="<your host machines username>"
USER_ID=$(id -u "$TARGET_USER")

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${USER_ID}/bus"

# Matches the NetworkManager connection name created earlier
if [ "$CONNECTION_ID" = "dock" ]; then
    case "$ACTION" in
        up)
            # Short sleep to ensure the network stack is ready
            sleep 1
	    # The part that mounts the pi :D
###            runuser -u "$TARGET_USER" -- sshfs <Your slave machines username>@10.10.10.2:/ /path/to/mount/directory -o reconnect,ServerAliveInterval=5,ServerAliveCountMax=3,idmap=user,IdentityFile=~/.ssh/id_ed25519
	    # Notifacations for docking
###            runuser -u "$TARGET_USER" -- notify-send -i drive-harddisk "Docked device detected" "The device should be mounted at your chosen location"

            ;;
        down|pre-down)
            # Safely unmount when the pi is disconnected (basically hot swap suppourt)
###            fusermount -u /path/to/mount/directory
            runuser -u "$TARGET_USER" -- notify-send -i drive-harddisk-usb "The device has been disconected"
            ;;
    esac
fi
