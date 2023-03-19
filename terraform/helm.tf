resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace = "cert-manager"


  # set {
  #   name  = "wait-for"
  #   value = module.cert_manager_irsa_role.iam_roles_arn

  # }

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "version"
    value = "v1.4.0"
  }

  # set {
  #   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com\\/role-arn"
  #   value = module.cert_manager_irsa_role.iam_roles_arn
  # }
  
  values = [
    "${file("helm_values/values-cert-manager.yaml")}"
  ]
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"

  create_namespace = true
  namespace = "cert-manager"


  # set {
  #   name  = "wait-for"
  #   value = module.external_dns_irsa_role.iam_roles_arn

  # }

  set {
    name  = "domainFilters"
    value = "{${local.domain}}"
  }

  set {
    name  = "installCRDs"
    value = "true"
  }
  # set {
  #   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com\\/role-arn"
  #   value = module.external_dns_irsa_role.iam_roles_arn
  # }

  # values = [
  #   "${file("helm_values/values-external-dns.yaml")}"
  # ]
}

resource "helm_release" "nginx" {
  name  = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"

  create_namespace = true
  namespace = "ingress-nginx"
}