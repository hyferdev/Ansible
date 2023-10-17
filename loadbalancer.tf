# Create Network Load Balancer
resource "aws_lb" "ansible_nlb" {
  name               = "ansible-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.ansible_subnet_a.id, aws_subnet.ansible_subnet_b.id, aws_subnet.ansible_subnet_c.id]
  enable_deletion_protection = false
}

# Create load balancer listener
resource "aws_lb_listener" "ansible_nlb_listener" {
  load_balancer_arn = aws_lb.ansible_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webservers.arn
  }
}

# Create target groups for the NLB
resource "aws_lb_target_group" "webservers" {
  name        = "ansible"
  port        = 80
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = aws_vpc.ansible_vpc.id
  stickiness {
    type = "source_ip"
  }
}
