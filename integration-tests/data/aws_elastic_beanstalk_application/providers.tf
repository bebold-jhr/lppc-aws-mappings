terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.63.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}
