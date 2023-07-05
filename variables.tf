variable "aws_region_primary" {
  description = "aws region"
  type        = string
  default     = "us-east-1"
}

variable "aws_region_secondary" {
  description = "aws region"
  type        = string
  default     = "us-east-2"
}


variable "project_name" {
  description = "ec2 instance type_pass this value using CLI when prompted"
  type        = string
  default     = "awss3cloudfront"
}




