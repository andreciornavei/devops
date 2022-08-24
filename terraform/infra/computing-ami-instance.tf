data "aws_ami" "ami_instance" {
  owners = ["amazon"]
  most_recent   = true

  filter {
    name   = "image-id"
    values = ["ami-0f5ae2c5d7a9b1720"]
  }

}