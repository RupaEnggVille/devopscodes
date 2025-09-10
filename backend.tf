terraform {
  backend "s3" {
    bucket = "terraformstatefile9925"
    key    = "Terraform/backend.tfstate"
    region = "us-east-1"
  }
}
