output "cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.ecs_cluster.name
}

output "cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.ecs_cluster.id
}

output "service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.ecs_service.name
}

output "task_definition_arn" {
  description = "Task definition ARN"
  value       = aws_ecs_task_definition.service.arn
}

output "ecs_task_sg_id" {
  description = "Security group ID for task ENIs"
  value       = aws_security_group.ecs_task_sg.id
}

output "ecs_instance_sg_id" {
  description = "ECS instances security group ID"
  value       = aws_security_group.ecs_instance_sg.id
}

output "launch_template_id" {
  description = "Launch template ID"
  value       = aws_launch_template.ec2_launch_template.id
}

output "asg_name" {
  description = "ASG name"
  value       = aws_autoscaling_group.asg.name
}

output "ecs_ami_id" {
  description = "ECS AMI ID from SSM Parameter Store"
  value       = data.aws_ssm_parameter.ecs_ami.value
}
