resource "aws_s3_bucket" "s3_bucket" {
   bucket = "rajen-terra-autogen"
   tags = {
     Name ="terrafor generated "
     Enviroment ="Test"
   }
}