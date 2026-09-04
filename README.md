# Silly-ethernet-docking-system
Mounts the filesystem of one device to another device over an ethernec connection when connected

## Setup
Place the .sh file into your `/etc/NetworkManager/dispatcher.d/` directory, and set the permission to an exicutable with the `chmod +x` command.

make sure the ethernet port of your host machine has an IPv4 address of 10.10.10.1, and the IP address of the slave devices ethernet port is 10.10.10.2.
You can do this by running `nmcli con add type ethernet con-name "dock" ifname <Your ethernet interface name> ip4 10.10.10.1/24` on the host machine, and `nmcli con add type ethernet con-name "dock" ifname <Your ethernet interface name> ip4 10.10.10.2/24` on the slave machine. To get the interface name run `ip link` on each machiene, and it'll be the one that makes the most sense for an ethernet port (For example on a raspbery pi, its called eth0). You can check the connection by pinging or SSHing into the device.

Next on the host machine run `ssh-keygen -t ed25519` and enter the password of the slave machine if asked, leave the file location as the default location, and leave the next 2 passwords blank so that it can mount automatically. Then run `ssh-copy-id <Slave machine account username>@10.10.10.2`.

Finally you need to edit the .sh file with sudo. All the lines that need editing are commented out with three hashtags, and must be uncommented for propper functionallity. Some lines may have multiple places that need editing, and I've tried to make it easy to find what needs editing.

## Extra things to know
While you can disconnect your docked device by simply pulling the ethernet cable, it's recomended to close anything that's currently using any of the files in the docked device (mainly things like your file explorer, and your terminal if you are currently cd'd into the device mount) as these will likely hang for a little while otherwise. If you forget to do this, you can just plug the device back in, and then the prossecces should catch up again, and you can then leave the docked device.
