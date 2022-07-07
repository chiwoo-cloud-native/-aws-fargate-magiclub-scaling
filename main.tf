locals {
  env         = lower( substr(var.environment, 0, 1))
  name_prefix = "${var.project}-${var.region}${local.env}"
  tags        = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
    Team        = var.team
  }
}

module "scaling_cpu" {
  source = "./modules/target-tracking/"

  name_prefix        = local.name_prefix
  ecs_cluster_name   = data.aws_ecs_cluster.this.cluster_name
  ecs_service_name   = data.aws_ecs_service.this.service_name
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
  metric             = var.metric
  target_value       = var.target_value
  scale_in_cooldown  = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  disable_scale_in   = var.disable_scale_in
}
