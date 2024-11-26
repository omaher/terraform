variable "AWS_REGION" {
  type    = string
  default = "us-east-1"
}

variable "AWS_AZ_1" {
  type    = string
  default = "us-east-1a"
}

variable "AWS_AZ_2" {
  type    = string
  default = "us-east-1b"
}

variable "vpc-cidr_block" {
  type    = string
  default = "192.168.1.0/16"
}

variable "public1-subnet-cidr_block" {
  type    = string
  default = "192.168.1.0/24"
}

variable "public2-subnet-cidr_block" {
  type    = string
  default = "192.168.2.0/24"
}

variable "private1-subnet-cidr_block" {
  type    = string
  default = "192.168.3.0/24"
}

variable "private2-subnet-cidr_block" {
  type    = string
  default = "192.168.4.0/24"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-012967cc5a8c9f891"
  }
}
