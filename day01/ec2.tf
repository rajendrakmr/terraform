data "aws_ami" "os_image" {
    most_recent      = true 
    owners            = ["099720109477"]
    filter {
      name   = "state"
      values = ["available"]
    }
    filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/*amd64*"]
    }
  
}
resource "aws_key_pair" "my_key" {
    key_name   = "terrakey"
    public_key = file("terrakey.pub") 
}

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "allow_to_connect" {
    name        = "allow_to_connect"
    description = "Allow inbound traffic on port 22 and 80"
    vpc_id      =  aws_default_vpc.default.id
    ingress{
        description = "allow inbound rule of 22"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow inbound rule of 80"
        from_port   = 80
        to_port     = 80 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow inbound rule of 443"
        from_port   = 443
        to_port     = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

    tags ={
        Name = "allow_to_connect"
        Enviroment="Dev"
    }
  
}

resource "aws_instance" "my_instance" {
    ami           = data.aws_ami.os_image.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_to_connect.id]
    key_name = aws_key_pair.my_key.key_name

    root_block_device {
      volume_size = 10
      volume_type = "gp3"
    }
    tags ={
        Name="Terra Auto server"
        Enviroment = "Dev"
    }
  
}