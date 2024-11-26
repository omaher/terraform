module "network" {
  source                     = "${env.WORKSPACE}/modules/network"
  AWS_AZ_1                   = var.AWS_AZ_1
  AWS_AZ_2                   = var.AWS_AZ_2
  vpc-cidr_block             = var.vpc-cidr_block
  public1-subnet-cidr_block  = var.public1-subnet-cidr_block
  public2-subnet-cidr_block  = var.public2-subnet-cidr_block
  private1-subnet-cidr_block = var.private1-subnet-cidr_block
  private2-subnet-cidr_block = var.private2-subnet-cidr_block
}

module "compute" {
  source            = "${env.WORKSPACE}/modules/compute"
  AWS_REGION        = var.AWS_REGION
  AMIS              = var.AMIS
  ecommerce_vpc-id  = module.network.ecommerce_vpc-id
  subnet-public1-id = module.network.subnet-public1-id
}
