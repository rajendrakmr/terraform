variable "instance_count" {
    default = 1
    description = "Aws instance count" 
}

variable "instance_type" {
    default =  "t2.micro"
    description = "Aws instance type"
  
}
variable "keypair_name" {
    default = "terrakey"
    description = "aws key pair name"
  
}
variable "security_name" {
    default = "allow_trafic_rule"
    description = "aws security group name"
  
}

variable "server_name" {
    default = "Terraform auto server"
    description = "Name of server"
  
}

variable "volume_size" {
    default = 12
    description = "Size of volume"
  
}