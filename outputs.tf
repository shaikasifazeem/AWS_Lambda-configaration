output "lambda_arns" {
  value       = { for k, v in aws_lambda_function.lambdas : k => v.arn }
  description = "A map of Lambda function names to their ARNs"
}

output "lambda_names" {
  value       = [for k, v in aws_lambda_function.lambdas : v.function_name]
  description = "A list of all deployed Lambda function names"
}

output "first_lambda_throttle_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.first_lambda_throttles.arn
  description = "The ARN of the first-lambda-function throttle alarm"
}

output "lambda_invocation_alarm_arns" {
  value       = { for k, v in aws_cloudwatch_metric_alarm.lambda_invocations : k => v.arn }
  description = "A map of Lambda function names to their invocation alarm ARNs"
}
