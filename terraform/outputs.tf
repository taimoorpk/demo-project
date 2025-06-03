output "lambda_function_name" {
  description = "The deployed Lambda function name"
  value       = length(aws_lambda_function.my_lambda) > 0 ? aws_lambda_function.my_lambda[0].function_name : ""
}