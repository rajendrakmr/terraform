resource "aws_key_pair" "my_key" {
    key_name    = var.instance_key_name
    public_key  = file("terra_auto_key.pub")
}

resource "aws_default_vpc" "defult" { 
}

resource "aws_security_group" "sg" {
    name        = var.instance_sg_name
    description = "Allow inbound traffic on port 22 and 80"
    vpc_id      = aws_default_vpc.defult.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow port 22"
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow port 80"
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow port 443"
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol =   "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "my_instance" {
    ami             = var.instance_ami_id
    count           = var.instance_count
    instance_type   = var.instance_type
    key_name        = aws_key_pair.my_key.key_name
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
      Name          = var.instance_name
      Enviroment    = "Dev"
    }

    root_block_device {
      volume_size = var.volume_size
      volume_type = "gp3"
    }
  
}