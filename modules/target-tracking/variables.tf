variable "name_prefix" { type = string }
variable "ecs_cluster_name" { type = string }
variable "ecs_service_name" { type = string }

### ECS Scaling Policy
variable "min_capacity" { type = number }
variable "max_capacity" { type = number }
variable "metric" {
  description = "The metric can choose one of the options `cpu`, `mem`, or `alb`."
  default     = "cpu"
}
variable "target_value" {
  description = "target_value is threshold of metric"
  type        = number
}
variable "scale_in_cooldown" { default = 300 }
variable "scale_out_cooldown" { default = 300 }
variable "disable_scale_in" { default = false }

/*
cpu_metric = {
  target_value = 70
  scale_in_cooldown = 300
  scale_out_cooldown = 300
  disable_scale_in = false
}
*/
#variable "cpu_metric" {
#  type    = map(string)
#  default = {}
#}
#
#variable "mem_metric" {
#  type    = map(string)
#  default = {}
#}
#
#variable "alb_metric" {
#  type    = map(string)
#  default = {}
#}
