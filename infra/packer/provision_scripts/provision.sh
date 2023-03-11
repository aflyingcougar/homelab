# Update OS packages
apt-get update
apt-get upgrade -y

# Remove the local machine ID
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Remove & regenerate SSH host keys
cat <<EOF > /etc/systemd/system/regenerate_ssh_host_keys.service;
[Unit]
Description=Regenerate SSH host keys
Before=ssh.service
ConditionFileIsExecutable=/usr/bin/ssh-keygen

[Service]
Type=oneshot
ExecStartPre=-/bin/dd if=/dev/hwrng of=/dev/urandom count=1 bs=4096
ExecStartPre=-/bin/sh -c "/bin/rm -f -v /etc/ssh/ssh_host_*_key*"
ExecStart=/usr/bin/ssh-keygen -A -v
ExecStartPost=/bin/systemctl disable regenerate_ssh_host_keys

[Install]
WantedBy=multi-user.target
EOF

chown root:root /etc/systemd/system/regenerate_ssh_host_keys.service
systemctl daemon-reload
systemctl enable regenerate_ssh_host_keys.service
