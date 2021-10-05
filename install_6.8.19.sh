#!/bin/bash

echo "create required directories"
sudo mkdir /var/lib/elasticsearch/v6.8
sudo mkdir /var/log/elasticsearch/v6.8


echo "download, expand elasticsearch & kibana archives"
pushd ~/elastic-stack
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.19.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.19.tar.gz.sha512
shasum -a 512 -c elasticsearch-6.8.19.tar.gz.sha512
tar -xzf elasticsearch-6.8.19.tar.gz
wget https://artifacts.elastic.co/downloads/kibana/kibana-6.8.19-linux-x86_64.tar.gz
shasum -a 512 kibana-6.8.19-linux-x86_64.tar.gz
tar -xzf kibana-6.8.19-linux-x86_64.tar.gz

echo "configure elasticsearch"
cd elasticsearch-6.8.19
echo "node.name: node-solo" >> config/elasticsearch.yml
echo "discovery.type: single-node" >> config/elasticsearch.yml
echo "path.data: /var/log/elasticsearch/v6.8" >> config/elasticsearch.yml
echo "cluster.name: v68" >> config/elasticsearch.yml
echo "bootstrap.memory_lock: true" >> config/elasticsearch.yml
echo "network.host: 10.0.0.120" >> config/elasticsearch.yml
echo "http.port: 9608" >> config/elasticsearch.yml
echo "action.destructive_requires_name: true" >> config/elasticsearch.yml
echo "xpack.security.enabled: true" >> config/elasticsearch.yml

popd
cat custom.jvm.options.yml >> ~/elastic-stack/elasticsearch-6.8.19/config/jvm.options

echo "configure kibana"
pushd ~/elastic-stack
cd kibana-6.8.19-linux-x86_64
echo "server.port: 5608" >> config/kibana.yml
echo "server.host: 10.0.0.120" >> config/kibana.yml
echo "server.name: Kibana.6.8" >> config/kibana.yml
echo "elasticsearch.hosts: ["http://10.0.0.120:9608"]" >> config/kibana.yml
