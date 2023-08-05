# Pulling the existing VPC atributes 
data "aws_vpc" "default_vpc" {
    id = "vpc-id12345"
}

data "aws_subnets_ids" "pulic" {
    vpc_id = data.aws_vpc.default_vpc.id 
}

resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Controls access to the ALB"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80 
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    protocol    = "-1"
    from_port   = 0 
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb" "myalb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets = data.aws_subnet_ids.public.ids
#   subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = true
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# Target group
resource "aws_lb_target_group" "app" {
  name        = "app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default_vpc.id
  target_type = "instance"

  health_check {
    enabled  = true
    interval = 30
    path     = "/health"
    port     = 80
    protocol = "HTTP"
    matcher  = "200" 
  }
}

#Looking up for existing instance with ID
data "aws_instance" "app" {
  instance_id = "i-012345678"
}
# Register target
resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = data.aws_instance.app.id
  port             = 80
}