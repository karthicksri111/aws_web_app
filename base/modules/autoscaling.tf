
resource "aws_launch_template" "LT1" {
  name_prefix = "example-lt1-"
  instance_type = "t2.micro"


  block_device_mappings {
  device_name = "/dev/sda1"

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

  user_data = filebase64("${path.module}/scripts/user_data.sh")

}