output "lambda_arn" {
  value       = aws_lambda_function.lambda.arn
  description = "The ARN of the Lambda function"
}

output "lambda_name" {
  value       = aws_lambda_function.lambda.function_name
  description = "The name of the Lambda function"
}
