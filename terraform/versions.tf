terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.51.0"
    }
    bunnynet = {
      source  = "BunnyWay/bunnynet"
      version = "0.14.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.20.0"
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