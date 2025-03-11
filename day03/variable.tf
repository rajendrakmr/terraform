variable "instance_type" {
    default     = "t2.micro"
    description = "Name of instance type" 
}
variable "instance_count" {
    default     = 1
    description = "Count of instance machine" 
}
variable "volume_size" {
  default       = 15
  description   = "Size of volume size"
}
variable "instance_key_name" {
    default     = "terra_auto_key"
    description = "Key name of instance" 
}

variable "instance_ami_id" {
    default     = "ami-03fd334507439f4d1"
    description = "ID of instance AMI"
  
}
variable "instance_name" {
    default = "Automate server"
    description = "Name of instance" 
}

variable "instance_sg_name" {
    default = "auto_sg_group"
    description = "Name of instance SG"
}