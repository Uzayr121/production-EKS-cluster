variable "route53_zone_arn" {
  description = "The ARN of the Route 53 hosted zone."
  type        = string
  
}
variable "oidc_provider_arn" {
  description = "The ARN of the OIDC provider for the EKS cluster."
  type        = string
  
}
variable "tags" {
  description = "A map of tags to assign to the IAM resources."
  type        = map(string)
  default     = {
    Environment = "sandbox",
    ManagedBy   = "Terraform",  
    CreatedBy   = "Uzayr"
  }
  
}
variable "cert-man-name" {
  description = "The name of the IAM role for cert-manager."
  type        = string
  
}
variable "dns-name" {
  description = "The DNS name for the external-dns service."
  type        = string
  
  
}
