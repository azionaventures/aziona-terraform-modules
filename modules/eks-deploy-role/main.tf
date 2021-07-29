locals {
  environment = var.environment
  organization_name = var.organization_name
  eks_region = var.eks_region
  ecr_region = var.ecr_region
}

resource "aws_iam_role_policy" "eks_deploy_role_policy" {
  name = "eks-deployer-role-policy-${local.environment}"
  role = aws_iam_role.eks_deploy_role.id

  policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "dynamodb:Describe*",
                    "dynamodb:Delete*",
                    "dynamodb:UpdateTimeToLive",
                    "dynamodb:List*",
                    "dynamodb:UpdateTable",
                    "dynamodb:TagResource",
                    "dynamodb:Create*",
                    "dynamodb:UntagResource",
                    "dynamodb:DeleteItem",
                    "dynamodb:GetItem",
                    "dynamodb:PutItem",
                ],
                "Resource": [
                    "arn:aws:dynamodb:*:*:table/terraform-lock",
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:Get*",
                    "s3:List*",
                    "s3:Put*",
                    "s3:*Object*",
                    "s3:*Object"
                ],
                "Resource": var.s3_buckets
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:GetAuthorizationToken"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:GetDownloadUrlForLayer",
                    "ecr:BatchGetImage",
                    "ecr:BatchCheckLayerAvailability",
                    "ecr:PutImage",
                    "ecr:InitiateLayerUpload",
                    "ecr:UploadLayerPart",
                    "ecr:CompleteLayerUpload"
                ],
                "Resource": "arn:aws:ecr:${local.ecr_region}:*:repository/*"
            },
            {
                "Effect": "Allow",
                "Action": "eks:*",
                "Resource": "arn:aws:eks:${local.eks_region}:*:cluster/${local.organization_name}-${local.environment}"
            },
            {
                "Effect": "Deny",
                "Action": "eks:Delete*",
                "Resource": "arn:aws:eks:${local.eks_region}:*:cluster/${local.organization_name}-${local.environment}"
            },
            {
                "Effect": "Allow",
                "Action": [
                "route53:Get*",
                "route53:List*",
                "route53:ChangeResourceRecordSets"
                ],
                "Resource": "arn:aws:route53:::hostedzone/*"
            }
        ]
    })
}

resource "aws_iam_role" "eks_deploy_role" {
  name = "eks-deployer-role-${local.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": var.arn_iam_users
            },
            "Action": [
                "sts:AssumeRole",
                "sts:TagSession"
            ]
        }
    ]      
  })
}