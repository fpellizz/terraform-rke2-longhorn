terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    gandi = {
      version = "~> 2.0"
      source  = "go-gandi/gandi"
    }
  }
}

#provider per AWS
provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

#provider per Gandi
provider "gandi" {
  key = "VoMx2Q1f3Nvh96wpGdRRGwYA"
}