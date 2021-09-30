#!/bin/bash
# Host preparation
sudo mkdir /var/lib/elasticsearch
sudo mkdir /var/log/elasticsearch
mkdir ~/elastic-stack
sudo chown 1000:1000 /var/log/elasticsearch

echo "Increase RLIMIT_MEMLOCK, soft limit: 67108864, hard limit: 67108864"
echo "modify /etc/security/limits.conf"
echo "# allow user 'gsmith' mlockall"
echo "your-username soft memlock unlimited"
echo "your-username hard memlock unlimited"
