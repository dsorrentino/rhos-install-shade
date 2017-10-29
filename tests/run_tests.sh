#!/bin/bash

source ~/shade/bin/activate

echo ""
echo ""
echo "This script will copy the undercloud PEM file (if needed) to the"
echo "stack user home directory to execute the following tests:"
echo ""
echo " - Execute Ansible Playbook (test_shade.yaml) using the os_image_facts module on"
echo "   the overcloud image from Glance."
echo ""
echo " - Execute Python Script (test_shade.py) displaying the properties"
echo "   about the overcloud image from Glance."
echo ""

UNDERCLOUD_PEM=$(sudo grep -i certs /etc/haproxy/haproxy.cfg | awk '{print $NF}' | sort -u)

if [[ ! -z "${UNDERCLOUD_PEM}" ]]
then
  echo ""
  echo "NOTE: SSL is being used by the undercloud. Copying the certificate file"
  echo "      to the stack user's home directory as:"
  echo ""
  echo "      undercloud.shade_test.pem"
  echo ""
  sudo cp ${UNDERCLOUD_PEM} /home/stack/undercloud.shade_test.pem
  sudo chmod 0600 /home/stack/undercloud.shade_test.pem
  sudo chown stack:stack /home/stack/undercloud.shade_test.pem
fi

echo ""
echo "Executing Ansible Playbook: ./test_shade.yaml"
echo "============================================="
echo ""

ansible-playbook ./test_shade.yaml

echo ""
echo "Executing Python script: ./test_shade.py"
echo "============================================="
echo ""

python ./test_shade.py
