schema-registry-cli
=====

A Command-line Schema Registry client based on curl, written in bash.

# How to use

```sh
# list the subjects, available with localhost:8083 endpoint.
schema-registry-cli subject list

# Can change the Schema Registry endpoint.
SCHEMA_REGISTRY_URL={schema-registry-url}:8081 schema-registry-cli subject list

# Dry run: shows appropriate curl command only.
SCHEMA_REGISTRY_URL={schema-registry-url}:8081 DRY_RUN=1 schema-registry-cli subject list

# Result with JQ: show installed connectors
SCHEMA_REGISTRY_URL={schema-registry-url}:8081 schema-registry-cli subject list | jq

# Input from stdin: Create a new subject
cat avro-schema.json | SCHEMA_REGISTRY_URL={schema-registry-url}:8081 schema-registry-cli subject create {subject-name}

# In Kubernetes: use 'env'.
kubectl -n default exec -it schema-registry-client -- env SCHEMA_REGISTRY_URL={schema-registry-url}:8081 schema-registry-cli subject list
```

# Docker Support

You can run this tool with provided docker image, `dongjinleekr/schema-registry-cli`. Below is the kubernetes pod configuration of this tool.

```
apiVersion: v1
kind: Pod
metadata:
  name: schema-registry-client
  namespace: default
spec:
  containers:
    - name: schema-registry-client
      image: dongjinleekr/schema-registry-cli:0.1
      command:
        - sh
        - -c
        - "exec tail -f /dev/null"
```

To build your own Docker image, run the following:

```sh
# Build 0.1
export SCHEMA_REGISTRY_CLI_VERSION=0.1 && docker build --build-arg schema_registry_cli_version=${SCHEMA_REGISTRY_CLI_VERSION} -t dongjinleekr/schema-registry-cli:${SCHEMA_REGISTRY_CLI_VERSION} .
```

