variable "aws_access_key" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "region" {
  description = "The aws region"
  type        = string
  default     = "eu-west-3"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "Project name"
    "Environment" = "Development"
    "Owner"       = "memyselfandi"
  }
}

variable "ami" {
  description = "Ami used for ec2"
  type        = string
  default     = "ami-0abb90b1685f9e9fc"
}

variable "key" {
  description = "key used for ec2"
  type        = string
  default     = "DevelopmentServiceParigi"
}

variable "elastic_ip" {
  description = "Elastic IP already present on aws region"
  type        = string
  default     = ""
}