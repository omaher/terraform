#Creating EC2 instance
resource "aws_instance" "ecommerce-frontend" {
  ami = lookup(var.AMIS,var.AWS_REGION)
  instance_type = "t2.micro"
  # VPC subnet
  subnet_id = var.subnet-public1-id
  # security group
  vpc_security_group_ids = [aws_security_group.security-group1.id]
  # public SSH key
  key_name = data.aws_key_pair.ecommerce-frontend.key_name
  tags = {
         Name = "ecommerce-frontend"
    }
}

