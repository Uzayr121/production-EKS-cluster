terraform {

  required_version = ">= 1.0.0"
  backend "s3" {
    bucket = "eks-provider-tfstate"
    key    = "Terraform/terraform.tfstate"
    region = "eu-west-2"
    #diynamodb_table = "terraform-lock-table"
    encrypt = true
  }
}