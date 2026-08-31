output "lambda_arns" {
  value       = { for k, v in aws_lambda_function.lambdas : k => v.arn }
  description = "A map of Lambda function names to their ARNs"
}

output "lambda_names" {
  value       = [for k, v in aws_lambda_function.lambdas : v.function_name]
  description = "A list of all deployed Lambda function names"
}

output "lambda_throttle_alarm_arns" {
  value       = { for k, v in aws_cloudwatch_metric_alarm.lambda_throttles : k => v.arn }
  description = "A map of Lambda throttle alarm ARNs"
}

output "lambda_invocation_alarm_arns" {
  value       = { for k, v in aws_cloudwatch_metric_alarm.lambda_invocations : k => v.arn }
  description = "A map of Lambda invocation alarm ARNs"
}
