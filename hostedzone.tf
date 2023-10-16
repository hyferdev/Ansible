# Create hosted subzone records, hzoneid is set in Terraform Cloud
resource "aws_route53_record" "ansible_record" {
  zone_id = var.hzoneid
  name    = "ansible.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.ansible_nlb.dns_name
    zone_id                = aws_lb.ansible_nlb.zone_id
    evaluate_target_health = true
  }
}

