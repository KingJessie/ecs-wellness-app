output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "ecs_instance_profile_name" {
  value = module.iam.ecs_instance_profile_name
}

output "ecs_task_execution_role_arn" {
  value = module.iam.ecs_task_execution_role_arn
}