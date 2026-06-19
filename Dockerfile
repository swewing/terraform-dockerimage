FROM hashicorp/terraform:1.15.6

RUN mkdir -p /var/plugin-cache

COPY plugin-cache /var/plugin-cache/