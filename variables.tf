variable "aws_region" {
  type    = string
  default = "ap-south-1"  
}

variable "lambda_functions" {
  type = map(object({
    handler_file = string
  }))
  default = {
    "first-lambda-function"  = { handler_file = "index" }
    "second-lambda-function" = { handler_file = "second_function" }
  }
}
