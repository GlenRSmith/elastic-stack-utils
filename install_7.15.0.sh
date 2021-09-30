#!/bin/bash

echo "create required directories"
sudo mkdir /var/lib/elasticsearch/v7.15
sudo mkdir /var/log/elasticsearch/v7.15

echo "download, expand elasticsearch & kibana archives"
pushd ~/elastic-stack
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.0-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.0-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-7.15.0-linux-x86_64.tar.gz.sha512
tar -xzf elasticsearch-7.15.0-linux-x86_64.tar.gz
curl -O https://artifacts.elastic.co/downloads/kibana/kibana-7.15.0-linux-x86_64.tar.gz
curl https://artifacts.elastic.co/downloads/kibana/kibana-7.15.0-linux-x86_64.tar.gz.sha512 | shasum -a 512 -c -
tar -xzf kibana-7.15.0-linux-x86_64.tar.gz

echo "configure elasticsearch"
cd elasticsearch-7.15.0
echo "node.name: node-solo" >> config/elasticsearch.yml
echo "path.data: /var/lib/elasticsearch/v7.15" >> config/elasticsearch.yml
echo "path.data: /var/log/elasticsearch/v7.15" >> config/elasticsearch.yml
echo "cluster.name: v715" >> config/elasticsearch.yml
echo "bootstrap.memory_lock: true" >> config/elasticsearch.yml
echo "http.port: 9715" >> config/elasticsearch.yml
echo "action.destructive_requires_name: true" >> config/elasticsearch.yml

popd
cp custom.jvm.options.yml ~/elastic-stack/elasticsearch-7.15.0/config/jvm.options.d/custom.yml

echo "configure kibana"
pushd ~/elastic-stack
cd kibana-7.15.0-linux-x86_64
echo "server.port: 5715" >> config/kibana.yml
echo "server.name: Kibana.7.15" >> config/kibana.yml
echo "elasticsearch.hosts: ["http://localhost:9715"]" >> config/kibana.yml
