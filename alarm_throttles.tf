# CloudWatch Metric Alarm for first-lambda-function Throttles
resource "aws_cloudwatch_metric_alarm" "first_lambda_throttles" {
  alarm_name          = "P1-[Formation]-[Lambda]-${each.key}-Throttles"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = 60
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alarm triggered when throttles>1"
  treat_missing_data  = "notBreaching"

  dimensions = {
    FunctionName = aws_lambda_function.lambdas["first-lambda-function"].function_name
  }
}
