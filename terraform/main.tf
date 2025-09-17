module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones
  tags                = var.tags
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  tags         = var.tags
}


module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  tags         = var.tags
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  certificate_arn   = module.acm.acm_certificate_validated_arn
  tags              = var.tags
}

module "ecs" {
  source             = "./modules/ecs"
  project_name       = var.project_name
  tags               = var.tags
  availability_zones = var.availability_zones
  region             = var.region
  image_tag          = var.image_tag

  vpc_id                      = module.vpc.vpc_id
  public_subnet_ids           = module.vpc.public_subnet_ids
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_instance_profile_name   = module.iam.ecs_instance_profile_name
  repository_url              = module.ecr.repository_url
  alb_sg_id                   = module.alb.alb_sg_id
  http_tg_arn                 = module.alb.http_tg_arn
}

module "acm" {
  source           = "./modules/acm"
  domain_name      = var.domain_name
  hosted_zone_name = var.hosted_zone_name
  tags             = var.tags
}