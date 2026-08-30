output "lambda_arns" {
  value       = { for k, v in aws_lambda_function.lambdas : k => v.arn }
  description = "A map of Lambda function names to their ARNs"
}

output "lambda_names" {
  value       = [for k, v in aws_lambda_function.lambdas : v.function_name]
  description = "A list of all deployed Lambda function names"
}
