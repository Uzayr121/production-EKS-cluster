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

    set {
    name = "serviceAccount.create"
      value = "true"
  }
  set {
    name = "serviceAccount.name"
      value = "cert-manager"
  }

     set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.cert_manager_irsa_arn
  }


   values = [
  file("C:/Users/uzayr/production-EKS-cluster/Terraform/Helm-values/cert-manager.yaml")
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
    name = "serviceAccount.create"
      value = "true"
  }
  set {
    name = "serviceAccount.name"
      value = "external-dns"
  }

     set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.external_dns_irsa_arn
  }



values = [
  file("C:/Users/uzayr/production-EKS-cluster/Terraform/Helm-values/external-dns.yaml")
]
 
}

resource "helm_release" "argocd-deploy" {
  name = var.argocd_name
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  timeout = "600"

  create_namespace = true
  namespace = "argocd"

values = [
  file("C:/Users/uzayr/production-EKS-cluster/Terraform/Helm-values/argocd.yaml")
]

depends_on = [ helm_release.cert_manager, helm_release.nginx_ingress, helm_release.external_dns ]


}

resource "helm_release" "kube-prom-graf" {
  name = var.prom_graf_name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  create_namespace = true
  namespace = "monitoring"

  values = [
    file("C:/Users/uzayr/production-EKS-cluster/Terraform/Helm-values/prom-graf.yaml")
  ] 

  depends_on = [ helm_release.nginx_ingress, helm_release.cert_manager, helm_release.external_dns ]

}