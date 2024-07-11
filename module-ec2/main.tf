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

data "aws_ami" "windows-ami" {
  filter {
    name = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  most_recent = true
  owners = ["amazon"]
}

resource "aws_security_group" "allow_http" {
  name        = "allow-http"
  description = "Allow http inbound traffic"
  vpc_id      = data.aws_vpc.selected.id
}

# Create aws ec2 instance for the app server
resource "aws_instance" "AFT-TestInstance1r" {
  ami                    = data.aws_ami.windows-ami.id
  instance_type          = var.instance
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  subnet_id              = data.aws_subnet.selected.id
  tags = {
    Name = "EC2-TerraformTest-Server"
    Env = "Test"
  }
}