#!/bin/bash

echo "[TASK 1] Join node to Kubernetes Cluster"
apt install -qq -y sshpass
sshpass -p "root" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no kmaster.batpool.com:/joincluster.sh /joincluster.sh 2>/dev/null
bash /joincluster.sh
