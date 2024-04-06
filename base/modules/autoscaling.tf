
resource "aws_launch_template" "LT1" {
  name = "LT1"
  instance_type = "t2.micro"
  image_id = "ami-0c101f26f147fa7fd"
  key_name = "KP1"

  block_device_mappings {
  device_name = "/dev/xvda"

    ebs {
      volume_size = 30
      volume_type = "gp3"
    }
  }

  vpc_security_group_ids = [aws_security_group.SG2.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Launch_Template Instance"
    }
  }

  user_data = filebase64("${path.module}/scripts/user_data.txt")

}

resource "aws_autoscaling_group" "ASG1" {
  name                 = "ASG1"
  launch_template {
    id      = aws_launch_template.LT1.id  # Specify the ID of your launch template
    version = "$Latest"  # Use the latest version of the launch template
  }
  min_size             = 1      # Minimum number of instances
  max_size             = 1      # Maximum number of instances
  desired_capacity     = 1      # Desired number of instances
  vpc_zone_identifier  = [aws_subnet.subnet_b.id, aws_subnet.subnet_d.id]  # Specify your subnet ID(s)
}










resource "aws_lb_target_group" "TG1" {
  name     = "TG1"
  port     = 80  # Specify the port on which the targets receive traffic
  protocol = "HTTP"  # Specify the protocol used for routing traffic (HTTP or HTTPS)
  vpc_id   = aws_vpc.vpc1.id

  # Specify health check configuration for the target group
  health_check {
    protocol = "HTTP"
    path     = "/"
    port     = "traffic-port"
  }
}


resource "aws_lb" "LB1" {
  name               = "LB1"
  internal           = false  # Set to true if this is an internal load balancer
  load_balancer_type = "application"  # Specify the type of load balancer (application or network)
  security_groups = [aws_security_group.SG1.id]
  subnets = [aws_subnet.subnet_a.id, aws_subnet.subnet_c.id]
}

resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.LB1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG1.arn
  }
}


resource "aws_autoscaling_attachment" "ASA1" {
  autoscaling_group_name = aws_autoscaling_group.ASG1.name
  lb_target_group_arn   = aws_lb_target_group.TG1.arn
}
