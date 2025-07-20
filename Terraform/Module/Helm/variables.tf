variable "cert_manager_name" {
  description = "The name of the cert-manager Helm release."
  type        = string
  
}

variable "cert_manager_irsa_arn" {
description = "The ARN of the cert-manager IRSA role."
type = string

}


variable "external_dns_name" {

description = "The name of the external-dns Helm release."
type = string
}

variable "external_dns_irsa_arn" {
description = "The ARN of the external-dns IRSA role."
type = string

}
variable "nginx_ingress_name" {
description = "The name of the NGINX Ingress controller Helm release."
type = string
}
variable "aws_region" {
  description = "The AWS region where the resources will be deployed."
  type        = string
  default = "eu-west-2"
  
}
variable "argocd_name" {
  description = "The name of the ArgoCD Helm release."
  type        = string
  
}
variable "prom_graf_name" {
  description = "The name of the Prometheus and Grafana Helm release."
  type        = string
  
}