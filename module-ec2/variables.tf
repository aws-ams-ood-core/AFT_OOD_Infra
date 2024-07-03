#--- module-ec2/variables.tf
# Create variable for aws_region
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
# Create variable for ami-id
variable "ami_id" {
  type    = string
  default = "ami-060a6d981e7de689d"
}
# Create variable for instance type
variable "instance" {
  type    = string
  default = "t2.micro"
}
# Create variable for cidr block
variable "cidr" {
  type    = string
  default = "10.0.1.0/24"
}
# Create variable for availability zone
variable "az" {
  type    = string
  default = "us-east-1a"
}
