provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = var.lambda_code_bucket
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = var.data_bucket
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda" {
  count         = var.deploy_lambda ? 1 : 0
  function_name = "my_lambda_function"
  s3_bucket     = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key        = "function.zip"
  runtime       = "python3.12"
  handler       = "function.lambda_handler"
  role          = aws_iam_role.lambda_exec_role.arn

  depends_on = [aws_s3_bucket.lambda_code_bucket]
}