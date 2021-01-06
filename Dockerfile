FROM alpine:3.12

ARG schema_registry_cli_version=0.1

LABEL org.label-schema.name="schema-registry-cli" \
      org.label-schema.description="Schema Registry command-line client" \
      org.label-schema.build-date="${build_date}" \
      org.label-schema.vcs-url="https://github.com/dongjinleekr/schema-registry-cli" \
      org.label-schema.vcs-ref="${vcs_ref}" \
      org.label-schema.version="${schema_registry_cli_version}" \
      org.label-schema.schema-version="1.0" \
      maintainer="dongjin@apache.org"

COPY schema-registry-cli /tmp/

RUN apk add --no-cache bash dumb-init curl jq \
 && chmod a+x /tmp/schema-registry-cli \
 && mv /tmp/schema-registry-cli /usr/bin \
 && sync

ENTRYPOINT [ "/usr/bin/dumb-init" ]

