# CloudWatch Metric Alarms for Lambda Throttles (Both functions)
resource "aws_cloudwatch_metric_alarm" "lambda_throttles" {
  for_each            = var.lambda_functions
  alarm_name          = "P1-[Formation]-[Lambda]-${each.key}-Throttles"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alarm triggered when ${each.key} experiences throttling"
  treat_missing_data  = "notBreaching"

  dimensions = {
    FunctionName = aws_lambda_function.lambdas[each.key].function_name
  }
}
