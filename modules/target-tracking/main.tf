locals {
  ecs_resource_id = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  metric_types    = {
    "cpu" = "ECSServiceAverageCPUUtilization"
    "mem" = "ECSServiceAverageMemoryUtilization"
    "alb" = "ALBRequestCountPerTarget"
  }
}

resource "aws_appautoscaling_target" "app_target" {
  service_namespace  = "ecs"
  resource_id        = local.ecs_resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

resource "aws_appautoscaling_policy" "asg_policy" {
  name               = "${var.name_prefix}-${var.ecs_service_name}-${var.metric}-policy"
  resource_id        = aws_appautoscaling_target.app_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.app_target.service_namespace

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = lookup(local.metric_types, var.metric, "ECSServiceAverageCPUUtilization")
    }

    target_value       = var.target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
    disable_scale_in   = var.disable_scale_in
  }

  depends_on = [
    aws_appautoscaling_target.app_target
  ]
}


/*
resource "aws_appautoscaling_policy" "asg_policy_cpu" {
  for_each           = var.cpu_metric
  name               = "${var.name_prefix}-${var.ecs_service_name}-cpu-policy"
  resource_id        = aws_appautoscaling_target.app_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.app_target.service_namespace

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = lookup(var.cpu_metric, "target_value")
    scale_in_cooldown  = lookup(var.cpu_metric, "scale_in_cooldown", 300)
    scale_out_cooldown = lookup(var.cpu_metric, "scale_out_cooldown", 300)
    disable_scale_in   = lookup(var.cpu_metric, "disable_scale_in", false)
  }

  depends_on = [
    aws_appautoscaling_target.app_target
  ]
}

resource "aws_appautoscaling_policy" "asg_policy_mem" {
  for_each           = var.mem_metric
  name               = "${var.name_prefix}-${var.ecs_service_name}-mem-policy"
  resource_id        = aws_appautoscaling_target.app_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.app_target.service_namespace

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = lookup(var.mem_metric, "target_value")
    scale_in_cooldown  = lookup(var.mem_metric, "scale_in_cooldown", 300)
    scale_out_cooldown = lookup(var.mem_metric, "scale_out_cooldown", 300)
    disable_scale_in   = lookup(var.mem_metric, "disable_scale_in", false)
  }

  depends_on = [
    aws_appautoscaling_policy.asg_policy_cpu
  ]

}


resource "aws_appautoscaling_policy" "asg_policy_alb" {
  for_each           = var.alb_metric
  name               = "${var.name_prefix}-${var.ecs_service_name}-alb-policy"
  resource_id        = aws_appautoscaling_target.app_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.app_target.service_namespace

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = lookup(var.alb_metric, "resource_label")
    }

    target_value       = lookup(var.alb_metric, "target_value")
    scale_in_cooldown  = lookup(var.alb_metric, "scale_in_cooldown", 300)
    scale_out_cooldown = lookup(var.alb_metric, "scale_out_cooldown", 300)
    disable_scale_in   = lookup(var.alb_metric, "disable_scale_in", false)
  }

  depends_on = [
    aws_appautoscaling_policy.asg_policy_mem
  ]

}
*/
