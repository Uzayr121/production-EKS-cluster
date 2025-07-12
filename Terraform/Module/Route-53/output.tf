output "route53_zone_id" {
  value = aws_route53_zone.domain.zone_id
  description = "The ID of the Route 53 hosted zone."
  
}
output "route53_zone_arn" {
  value = aws_route53_zone.domain.arn
  description = "The ARN of the Route 53 hosted zone."
  
}