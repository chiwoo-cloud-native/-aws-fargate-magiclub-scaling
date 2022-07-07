### Project Information
variable "project" { type = string }
variable "region" { type = string }
variable "environment" { type = string }
variable "domain" { type = string }
variable "owner" { type = string }
variable "team" { type = string }
variable "container_name" { type = string }

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
