terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" // Use an appropriate AWS provider version
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  # Backend is configured implicitly by HCP Terraform Workspace
}

provider "aws" {
  region = "us-west-2" // Ensure correct region
}