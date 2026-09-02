#!/bin/bash

IFACE="$1"
ACTION="$2"
TARGET_USER="theo"
USER_ID=$(id -u "$TARGET_USER")

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${USER_ID}/bus"

# Matches the NetworkManager connection name created earlier
if [ "$CONNECTION_ID" = "pi-dock" ]; then
    case "$ACTION" in
        up)
            # Short sleep to ensure the network stack is ready
            sleep 1
	    # The part that mounts the pi :D
            runuser -u theo -- sshfs theo@10.10.10.2:/ /pi -o reconnect,ServerAliveInterval=5,ServerAliveCountMax=3,idmap=user,IdentityFile=/home/theo/.ssh/id_ed25519
	    # Notifacations for docking
            runuser -u "$TARGET_USER" -- notify-send -i drive-harddisk "Piberdeck detected" "The device should be mounted at /pi"

            ;;
        down|pre-down)
            # Safely unmount when the pi is disconnected (basically hot swap suppourt)
            fusermount -u /pi
            runuser -u "$TARGET_USER" -- notify-send -i drive-harddisk-usb "Piberdeck has been disconected"
            ;;
    esac
fi
