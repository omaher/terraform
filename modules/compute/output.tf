output "instance-public-ip" {
        value=aws_instance.ecommerce-frontend.public_ip
}

output "service-group-id" {
	value=aws_security_group.security-group1.id
}
