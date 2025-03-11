data "aws_ami" "os_image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*amd64*"]
  }

}

resource "aws_key_pair" "local_key" {
  key_name   = var.keypair_name
  public_key = file("day02key.pub")
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_sg" {
  name        = var.security_name
  description = "Allow inbound traffic on port 22 and 80"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "Z plus security group allowed"
    Enviroment = "Dev"
  }

}

resource "aws_instance" "my_instance" {
  count                  = var.instance_count
  ami                    = data.aws_ami.os_image.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name               = aws_key_pair.local_key.key_name
  tags = {
    Name = var.server_name
  }
  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
  }

}
