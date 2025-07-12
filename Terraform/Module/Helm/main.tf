resource "helm_release" "cert_manager" {
    name = var.cert_manager_name
    repository = "https://charts.jetstack.io"
    chart = "cert-manager"
    version = "v1.12.0"
    
    create_namespace = true
    namespace = "cert-manager"
    set {
        name  = "installCRDs"
        value = "true"
    }
    values = [
        "${file("C:/Users/uzayr/production-EKS-cluster/Terraform/Helm-values/cert-manager.yaml")}"
    ]
}

resource "helm_release" "nginx_ingress" {

 name = var.nginx_ingress_name
 repository = "https://kubernetes.github.io/ingress-nginx"
 chart = "ingress-nginx"
 version = "4.0.6"

 create_namespace = true
 namespace = "ingress-nginx"

}



resource "helm_release" "external_dns" {
 name = var.external_dns_name
 repository = "https://kubernetes-sigs.github.io/external-dns/"
 chart = "external-dns"
 create_namespace = true

 namespace = "external-dns"

 set {
  name  = "serviceAccount.name"
  value = "external-dns"
}

set {
  name  = "serviceAccount.create"
  value = "true"
}
set {
  name  = "aws.region"
  value = var.aws_region
}


set {
  name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  value = var.external_dns_irsa_arn
}
 
}