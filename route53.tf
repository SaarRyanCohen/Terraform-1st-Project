resource "aws_route53_zone" "coolestaiart" {
  name          = "coolestaiart.com"
  comment       = "coolestaiart Zone"
  force_destroy = false
}

output "zone_id" {
  value = aws_route53_zone.coolestaiart.zone_id
}

resource "aws_route53_record" "trecord" {
  zone_id = aws_route53_zone.coolestaiart.zone_id
  name    = "trf.coolestaiart.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.tr-task.public_ip]
}