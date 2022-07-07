data "aws_ecs_cluster" "this" {
  cluster_name = "${local.name_prefix}-ecs"
}

data "aws_ecs_service" "this" {
  cluster_arn  = data.aws_ecs_cluster.this.arn
  service_name = var.container_name
}
