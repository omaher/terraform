variable "AWS_REGION" {
        type = string
        default = "us-east-1"
}
variable "AMIS" {
        type = map
        default = {
        us-east-1 = "ami-012967cc5a8c9f891"
        }
}

data "aws_key_pair" "ecommerce-frontend" {
  key_name = "ecommerce-frontend"
}

variable "ecommerce_vpc-id" {
        type = string
}

variable "subnet-public1-id" {
        type = string
}