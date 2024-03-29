#!/bin/bash
# Created by Topology-Converter v4.7.0
#    Template Revision: v4.7.0

function error() {
  echo -e "\e[0;33mERROR: The Zero Touch Provisioning script failed while running the command $BASH_COMMAND at line $BASH_LINENO.\e[0m" >&2
}
trap error ERR

SSH_URL="http://10.255.7.1/authorized_keys"
#Setup SSH key authentication for Ansible
mkdir -p /home/cumulus/.ssh
wget -O /home/cumulus/.ssh/authorized_keys $SSH_URL
sed -i '/iface eth0/a \ vrf mgmt' /etc/network/interfaces
cat <<EOT >> /etc/network/interfaces
auto mgmt
iface mgmt
  address 127.0.0.1/8
  vrf-table auto
EOT

echo "cumulus ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10_cumulus

reboot
exit 0
#CUMULUS-AUTOPROVISIONING