// ./iam_roles.tf
# data "aws_iam_policy_document" "externaldns_assume" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"
#       values   = ["system:serviceaccount:external-dns:external-dns"]
#     }

#     principals {
#       identifiers = [module.eks.oidc_provider_arn]
#       type        = "Federated"
#     }
#   }
# }

# data "aws_iam_policy_document" "externaldns_role" {
#   statement {
#     effect    = "Allow"
#     actions   = ["route53:ChangeResourceRecordSets"]
#     resources = ["arn:aws:route53:::hostedzone/*"]
#   }
#   statement {
#     effect    = "Allow"
#     actions   = ["route53:ListHostedZones", "route53:ListResourceRecordSets"]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_role" "externaldns_route53" {
#   assume_role_policy = data.aws_iam_policy_document.externaldns_assume.json
#   name               = "externaldns_route53"
#   inline_policy {
#     name   = "externaldns_role"
#     policy = data.aws_iam_policy_document.externaldns_role.json
#   }
# }

module "cert_manager_irsa_role" {
    source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
    version = "5.2.0"

    role_name = "cert-manager"
    attache_cert_manager_policy = true
    cert_manager_hosted_zone_arns = ["arn:aws:route53:::hostedzone/Z0600261OY5QAKYH2M34"]

    oidc_providers = {
        eks = {
            provider_arn               = module.eks.oidc_provider_arn
            namespace_service_accounts = ["kube-system:cert-manager"]
        }
    }


}

module "external_dns_irsa_role" {
    source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
    version = "5.2.0"

    role_name = "external-dns"
    attach_external_dns_policy = true
    external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/Z0600261OY5QAKYH2M34"]

    oidc_providers = {
        eks = {
            provider_arn               = module.eks.oidc_provider_arn
            namespace_service_accounts = ["kube-system:cert-manager"]
        }
    }
}