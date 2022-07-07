project        = "magiclub"
region         = "an2" # AWS region alias
environment    = "PoC"
domain         = "sympledemo.tk"
owner          = "symplesims@gmail.com"
team           = "DevOps"
container_name = "lotto"

min_capacity       = 1
max_capacity       = 10
metric             = "cpu"
target_value       = 70
scale_in_cooldown  = 300
scale_out_cooldown = 300
disable_scale_in   = false
