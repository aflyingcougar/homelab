# Update OS packages
apt-get update
apt-get upgrade -y

# Remove the local machine ID
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id