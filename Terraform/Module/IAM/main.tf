module "cert-manager-irsa-role" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                       = "5.52.2"
  role_name                     = var.cert-man-name
  attach_cert_manager_policy    = true
  cert_manager_hosted_zone_arns = [var.route53_zone_arn]
  oidc_providers = {
    eks = {
      provider_arn               = var.oidc_provider_arn
      # The namespace and service account for cert-manager
      namespace_service_accounts = ["cert-manager:cert-manager"] # the first value here is the namespace and the second value is the service account name
    }
  }
  tags = var.tags
}


module "external-dns-irsa-role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.52.2"

  role_name                     = var.dns-name
  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = [var.route53_zone_arn]

  oidc_providers = {
    eks = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["external-dns:external-dns"] # the first value here is the namespace and the second value is the service account name
    }
  }

  tags = var.tags
}