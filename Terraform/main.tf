module "VPC" {
  source                   = "C:/Users/uzayr/production-EKS-cluster/Terraform/Module/VPC"
  vpc_name                 = "production-vpc"
  public_subnet_name_1     = "public-subnet-1"
  public_subnet_name_2     = "public-subnet-2"
  public_subnet_name_3     = "public-subnet-3"
  private_subnet_name_1    = "private-subnet-1"
  private_subnet_name_2    = "private-subnet-2"
  private_subnet_name_3    = "private-subnet-3"
  nat_gway                 = "nat-gateway"
  internet_gway            = "internet-gateway"
  public_route_table_name  = "public-route-table"
  private_route_table_name = "private-route-table"

}
module "Route53" {
  source    = "C:/Users/uzayr/production-EKS-cluster/Terraform/Module/Route-53"
  zone_name = "eks.uzayr.uk"

}
module "EKS" {
  source              = "C:/Users/uzayr/production-EKS-cluster/Terraform/Module/EKS"
  cluster_name        = "production-eks-cluster"
  vpc_id              = module.VPC.vpc_id
  public_subnet_id_1  = module.VPC.public_subnet_id_1
  public_subnet_id_2  = module.VPC.public_subnet_id_2
  public_subnet_id_3  = module.VPC.public_subnet_id_3
  private_subnet_id_1 = module.VPC.private_subnet_id_1
  private_subnet_id_2 = module.VPC.private_subnet_id_2
  private_subnet_id_3 = module.VPC.private_subnet_id_3
  depends_on          = [module.Route53, module.VPC]

}
module "IAM" {
  source            = "C:/Users/uzayr/production-EKS-cluster/Terraform/Module/IAM"
  route53_zone_arn  = module.Route53.route53_zone_arn
  oidc_provider_arn = module.EKS.oidc_provider_arn
  cert-man-name     = "cert-manager-irsa-role"
  dns-name          = "external-dns-irsa-role"
  depends_on = [ module.EKS, module.Route53, module.VPC ]
}

module "Helm" {
  source                = "C:/Users/uzayr/production-EKS-cluster/Terraform/Module/Helm"
  cert_manager_name     = "cert-manager"
  nginx_ingress_name    = "nginx-ingress"
  external_dns_name     = "external-dns"
  argocd_name           = "argocd"
  external_dns_irsa_arn = module.IAM.external_dns_irsa_arn
  cert_manager_irsa_arn = module.IAM.cert_manager_irsa_arn
  depends_on            = [module.EKS, module.IAM]

}
