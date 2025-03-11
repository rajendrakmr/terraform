resource "aws_s3_bucket" "s3_bucket" {
    bucket = "lock-bucket"
    tags = {
      Name =""
    }
  
}