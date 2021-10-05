This utility is to help install and run Elasticsearch and Kibana.

It provides two distinct capabilities:

- Set up multiple versions of Elasticsearch & Kibana on the same host
- Install latest version of Elasticsearch & Kibana

It is not intended to support both capabilities on the same host.

# Multiple versions

This uses "archive" (tar.gz) installers.

prep_host.sh sets up the host for the first time.
install_<version>.sh:
- downloads elasticsearch & kibana archives for the specified version
- unpacks the archives
- updates the configuration files

run_es_<version>.sh runs the previously "installed" Elasticsearch.
run_kibana_<version>.sh runs the previously "installed" Kibana.

# Latest version

See `elastic_install_instructions.txt`
