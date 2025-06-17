terraform {
  required_providers {
    clevercloud = {
      source = "clevercloud/clevercloud"
      version = "0.9.0"
    }
  }
}

provider "clevercloud" {
  # Configuration options
  organisation = var.organization_id
}

resource "clevercloud_fsbucket" "fs-test-01" {
  name   = "fs-test-01"
  region = "par"
  
}

