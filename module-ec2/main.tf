resource "aws_vpc" "TestVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "AFT-Test"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.AFT-Test.id
  cidr_block              = var.cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}
resource "aws_security_group" "allow_http" {
  name        = "allow-http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.AFT-Test.id
}
# Create aws ec2 instance for the app server
resource "aws_instance" "AFT-TestInstance1r" {
  ami                    = var.ami_id
  instance_type          = var.instance
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  subnet_id              = aws_subnet.public_subnet.id
  tags = {
    Name = "EC2-App-Server"
  }
}
