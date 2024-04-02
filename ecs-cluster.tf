# --- ECS Cluster --- 

resource "aws_ecs_cluster" "cluster" {
  name = "${var.env}_ECS"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# --- ECS Capacity Provider Setup with EC2 AutoScaling Group ---

resource "aws_ecs_capacity_provider" "main" {
  name = "${var.env}_EC2"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

# --- ECS Cluster Capacity Provider with Both Fargate and EC2 AutoScaling Group---
resource "aws_ecs_cluster_capacity_providers" "cluster" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE_SPOT", "FARGATE", aws_ecs_capacity_provider.main.name]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }
}