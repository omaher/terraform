output "ecommerce_vpc-id" {
        value=aws_vpc.vpc-ecommerce.id
}

output "subnet-public1-id" {
		value=aws_subnet.vpc-ecommerce-public1.id
}

output "subnet-public2-id" {
		value=aws_subnet.vpc-ecommerce-public1.id
}

output "subnet-private1-id" {
		value=aws_subnet.vpc-ecommerce-private1.id
}

output "subnet-private2-id" {
		value=aws_subnet.vpc-ecommerce-private2.id
}
