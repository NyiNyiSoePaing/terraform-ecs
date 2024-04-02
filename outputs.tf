# outputs.tf

# output "VPC" {
#   value = aws_vpc.main.name
# }

output "alb_hostname" {
  value = aws_alb.main.dns_name
}

output "ECS_CLuster_Name" {
  value = aws_ecs_cluster.cluster.name
}