terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-2310"
    key    = "lambda-deployment/terraform.tfstate"
    region = "eu-west-2"
  }
}