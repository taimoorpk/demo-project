variable "region" {
  default = "eu-west-2"
}

variable "lambda_code_bucket" {
  default = "my-lambda-code-bucket-231017"
}

variable "data_bucket" {
  default = "my-data-storage-bucket-231017"
}

variable "deploy_lambda" {
  description = "Whether to deploy the Lambda function"
  type        = bool
  default     = false
}