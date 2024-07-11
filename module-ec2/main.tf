data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["TerraformTestVPC"]
  }
}
data "aws_subnet" "selected" {
  filter {
    name = "tag:Name"
    values = ["subnet-d40156b2"]
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow-http"
  description = "Allow http inbound traffic"
  vpc_id      = data.aws_vpc.selected.id
}
# Create aws ec2 instance for the app server
resource "aws_instance" "AFT-TestInstance1r" {
  ami                    = var.ami_id
  instance_type          = var.instance
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  subnet_id              = data.aws_subnet.selected.id
  tags = {
    Name = "EC2-TerraformTest-Server"
  }
}