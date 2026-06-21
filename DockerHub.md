# Terraform with cached providers

Based on [`hashicorp/terraform`](https://hub.docker.com/r/hashicorp/terraform), with commonly used providers pre-populated in the Terraform plugin cache to speed up pipeline builds.

See [`github.com/swewing/terraform-dockerimage`](https://github.com/swewing/terraform-dockerimage) for the image build repository and release notes.

## Included providers

- `archive`
- `aws`
- `bunnynet`
- `cloudflare`
- `time`

## Tags & versioning

Tags follow the pattern `<terraform-version>-<build-date>`, for example:

```
1.15.6-20260618
```

This image is based on `hashicorp/terraform:1.15.6` and includes the latest versions of the providers listed above as of the build date (`20260618`, i.e. 18 June 2026). Images are rebuilt periodically to pick up newer provider releases and Terraform versions.

## Usage

Pull the image:

```sh
docker pull swewing/terraform:latest
```

or a specific version, eg:

```sh
docker pull swewing/terraform:1.15.6-20260618
```

Point Terraform at the bundled plugin cache:

```sh
export TF_PLUGIN_CACHE_DIR="/var/plugin-cache"
```