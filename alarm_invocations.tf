# CloudWatch Metric Alarms for Lambda Invocations (Both functions)
resource "aws_cloudwatch_metric_alarm" "lambda_invocations" {
  for_each            = var.lambda_functions
  alarm_name          = "P1-[Formation]-[Lambda]-${each.key}-Invocations"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Invocations"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = 100
  alarm_description   = "Triggered when invocations exceed 100 in 5 minutes for ${each.key}"
  treat_missing_data  = "notBreaching"

  dimensions = {
    FunctionName = aws_lambda_function.lambdas[each.key].function_name
  }
}
