FROM hashicorp/terraform:1.15.7

RUN mkdir -p /var/plugin-cache

COPY plugin-cache /var/plugin-cache/