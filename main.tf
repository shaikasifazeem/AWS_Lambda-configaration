# Shared IAM Role using name_prefix to avoid duplicate name errors
resource "aws_iam_role" "lambda_exec" {
  name_prefix = "lambda-exec-role-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach basic execution permissions
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Archive each Lambda code file
data "archive_file" "lambda_zip" {
  for_each    = var.lambda_functions
  type        = "zip"
  source_file = "${path.module}/src/${each.value.handler_file}.py"
  output_path = "${path.module}/${each.key}.zip"
}

# Create all Lambda functions
resource "aws_lambda_function" "lambdas" {
  for_each         = var.lambda_functions
  function_name    = each.key
  role             = aws_iam_role.lambda_exec.arn
  handler          = "${each.value.handler_file}.lambda_handler"
  runtime          = "python3.12"
  filename         = data.archive_file.lambda_zip[each.key].output_path
  source_code_hash = data.archive_file.lambda_zip[each.key].output_base64sha256

  timeout     = 10
  memory_size = 128

  environment {
    variables = {
      ENV = "production"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic_execution
  ]
}
