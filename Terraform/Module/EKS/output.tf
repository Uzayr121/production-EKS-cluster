output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
  description = "The ARN of the OIDC provider for the EKS cluster."
  
}
output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "The endpoint of the EKS cluster."
  
}
output "cluster_certificate_authority_data" {
  description = "EKS cluster certificate authority data"
  value       = module.eks.cluster_certificate_authority_data
}
output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster."  
  
}