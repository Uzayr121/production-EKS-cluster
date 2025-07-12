terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }

  }
}

provider "aws" {
  region = "eu-west-2"

}

provider "helm" {
  kubernetes {
    host                   = module.EKS.cluster_endpoint
    cluster_ca_certificate = base64decode(module.EKS.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1"
      args        = ["eks", "get-token", "--cluster-name", module.EKS.cluster_name]
      command     = "aws"
    }
  }
}