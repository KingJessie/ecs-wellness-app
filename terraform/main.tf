module "name" {
    source = "./modules/vpc"
    
    vpc_name            = var.vpc_name
    vpc_cidr            = var.vpc_cidr
    public_subnet_cidrs = var.public_subnet_cidrs
    availability_zones  = var.availability_zones
    tags                = var.tags
}       