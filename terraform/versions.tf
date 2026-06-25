terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.52.0"
    }
    bunnynet = {
      source  = "BunnyWay/bunnynet"
      version = "0.15.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.21.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.14.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.8.0"
    }
  }
}