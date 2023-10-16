#Create the launch template for your Auto Scale Group
resource "aws_launch_template" "ansible_launch_template" {
  name = "WebServers"
  image_id = var.ami

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 50
      volume_type = "gp2"
      delete_on_termination = true
    }
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = false
  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type
  key_name = var.keys

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination = true
    description = "Primary network interface"
    device_index = 0
    security_groups = [aws_security_group.ansible_sg.id]
  }
}

#Create your Auto Scale Group
resource "aws_autoscaling_group" "ansible_asg" {
  name = "WebServers-ASG"
  launch_template {
    id = aws_launch_template.ansible_launch_template.id
    version = aws_launch_template.ansible_launch_template.latest_version
  }
  desired_capacity = var.desired_capacity
  min_size = var.min_max_size[0]
  max_size = var.min_max_size[1]
  vpc_zone_identifier = [aws_subnet.ansible_subnet_a.id, aws_subnet.ansible_subnet_b.id, aws_subnet.ansible_subnet_c.id]
  target_group_arns = [aws_lb_target_group.webservers.arn]

  tag {
    key                 = "Name"
    value               = "WebServers"
    propagate_at_launch = true
  }
}

#Attach loadbalancer to instances created by Auto Scale Group
resource "aws_autoscaling_attachment" "webservers_target" {
  autoscaling_group_name = aws_autoscaling_group.ansible_asg.name
  lb_target_group_arn  = aws_lb_target_group.webservers.arn
}
