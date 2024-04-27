provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.6.0" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 6.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-verito"
    key            = "infra_state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-verito-dynamodb"
    encrypt        = true
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}
