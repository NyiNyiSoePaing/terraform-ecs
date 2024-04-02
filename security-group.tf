# Create Security Group for the Application Load Balancer (ALB)
resource "aws_security_group" "alb" {
  name        = "${replace(var.env, "_", "-")}-alb"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.main.id

  # Inbound Rules
  # Allow HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic from anywhere"
  }

  # Allow HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic from anywhere"
  }

  # Outbound Rules
  # Allow all outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.env} ALB Security Group"
  }
}

# Create Security Group for the Elastic Container Service (ECS)
resource "aws_security_group" "ecs" {
  name        = "${replace(var.env, "_", "-")}-ecs"
  description = "ECS Security Group: Enable HTTP/HTTPS access on Port 80/443 via ALB"
  vpc_id      = aws_vpc.main.id

  # Inbound Rules
  # Allow HTTP traffic from ALB
  ingress {
    description     = "Allow HTTP traffic from ALB"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb.id]
  }

  # Outbound Rules
  # Allow all outbound traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.env} ECS Security Group"
  }
}
