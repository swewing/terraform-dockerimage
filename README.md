# terraform-dockerimage

Builds a Docker image based on [`hashicorp/terraform`](https://hub.docker.com/r/hashicorp/terraform) with a set of commonly used Terraform providers pre-populated in the plugin cache. This avoids re-downloading providers on every `terraform init` and speeds up CI/pipeline builds.

The published image lives at [`swewing/terraform`](https://hub.docker.com/r/swewing/terraform) on Docker Hub. `DockerHub.md` is the description shown there; this README documents the repository itself.

This is a personal project for my own use and therefore the providers are what I personally require, not open to discussion at this time. The build instructions have however been provided should you wish to replicate this for yourself.

## How it works

1. `terraform/versions.tf` declares the providers and pins the exact versions to bundle.
2. Running `terraform init` against that config with `TF_PLUGIN_CACHE_DIR` set populates a local `plugin-cache/` directory with the provider binaries.
3. The `Dockerfile` copies `plugin-cache/` into `/var/plugin-cache` in the image, on top of `hashicorp/terraform`.
4. Consumers point `TF_PLUGIN_CACHE_DIR=/var/plugin-cache` at the bundled cache so `terraform init` reuses the cached providers instead of downloading them.

```
.
├── Dockerfile            # FROM hashicorp/terraform, copies the plugin cache in
├── terraform/
│   └── versions.tf       # providers + pinned versions to bundle
├── DockerHub.md          # description published to Docker Hub
└── README.md
```

> The `plugin-cache/` directory is generated at build time and is not committed (`.terraform` and `.terraform.lock.hcl` are git-ignored).

## Included providers

| Provider     | Source                 | Version  |
| ------------ | ---------------------- | -------- |
| `aws`        | `hashicorp/aws`        | 6.51.0   |
| `cloudflare` | `cloudflare/cloudflare`| 5.20.0   |
| `bunnynet`   | `BunnyWay/bunnynet`    | 0.14.3   |
| `archive`    | `hashicorp/archive`    | 2.8.0    |
| `time`       | `hashicorp/time`       | 0.14.0   |

The base image is `hashicorp/terraform:1.15.6` (see the `FROM` line in the `Dockerfile`).

## Building the image

From the repository root, populate the plugin cache and then build:

```sh
# 1. Generate the plugin cache from terraform/versions.tf
mkdir -p plugin-cache
TF_PLUGIN_CACHE_DIR="$(pwd)/plugin-cache" terraform -chdir=terraform init

# 2. Build the image (copies plugin-cache/ into /var/plugin-cache)
docker build -t swewing/terraform:latest .
```

Tags follow the pattern `<terraform-version>-<build-date>`, e.g. `1.15.6-20260618`. Tag and push:

```sh
docker tag swewing/terraform:latest swewing/terraform:1.15.6-20260618
docker push swewing/terraform:1.15.6-20260618
docker push swewing/terraform:latest
```

## Updating providers or Terraform version

- **Provider versions** — edit the pinned `version` values in `terraform/versions.tf`, then rebuild (the `terraform init` step re-populates the cache).
- **Adding a provider** — add a new block to `required_providers` in `terraform/versions.tf` and update the table above.
- **Terraform version** — bump the tag in the `FROM` line of the `Dockerfile`.

Rebuild periodically to pick up newer provider releases and Terraform versions.

## Usage

Pull the image:

```sh
docker pull swewing/terraform:latest
```

Point Terraform at the bundled plugin cache:

```sh
export TF_PLUGIN_CACHE_DIR="/var/plugin-cache"
```

See `DockerHub.md` for the consumer-facing usage notes.
