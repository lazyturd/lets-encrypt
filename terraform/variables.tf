variable "vpc_cidr_block" {}
variable "private_subnet_cidr_blocks" {}
variable "public_subnet_cidr_blocks" {}
variable "region" {
    type = string
    description = "aws region"
    default = "us-east-1"
}