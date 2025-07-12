variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created."
  type        = string
  
}
variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "production-eks-cluster"
}
variable "public_subnet_id_1" {
  description = "The ID of the first public subnet."
  type        = string
}
variable "public_subnet_id_2" {
  description = "The ID of the second public subnet."
  type        = string
}
variable "public_subnet_id_3" {
  description = "The ID of the third public subnet."
  type        = string
}
variable "private_subnet_id_1" {
  description = "The ID of the first private subnet."
  type        = string
}
variable "private_subnet_id_2" {
  description = "The ID of the second private subnet."
  type        = string
}
variable "private_subnet_id_3" {
  description = "The ID of the third private subnet."
  type        = string
}
variable "tags" {
    description = "A map of tags to assign to the EKS cluster and its resources."
    type        = map(string)
    default     = {
        "Environment" = "sandbox",
        "ManagedBy"   = "Terraform",
        "CreatedBy"   = "Uzayr"
    }
}