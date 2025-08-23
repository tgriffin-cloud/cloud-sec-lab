############################################################
# Security Auditor Role (assumable with MFA by this account)
############################################################

# Replace this with the actual 12-digit AWS account ID if different

locals {
# Stores the AWS account ID, instead of writing the account number, reference local.account_id
  account_id = "868295555863"
}

# Trust policy: only principals in this account may assume, AND MFA must be present
data "aws_iam_policy_document" "auditor_trust" {
  statement {
    sid    = "AllowSameAccountWithMFA"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_role" "security_auditor" {
  name               = "SecurityAuditorRole"
  assume_role_policy = data.aws_iam_policy_document.auditor_trust.json

  tags = {
    Project     = "CloudSecurityLab"
    Environment = "Sandbox"
    Owner       = "Tontrisha"
    ManagedBy	= "Terraform"
  }
}

# Attach AWS-managed read-only policies suitable for auditing
resource "aws_iam_role_policy_attachment" "auditor_securityaudit" {
  role       = aws_iam_role.security_auditor.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy_attachment" "auditor_readonly" {
  role       = aws_iam_role.security_auditor.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

############################################################
# Group allowed to assume the role + permissions + membership
############################################################

resource "aws_iam_group" "security_auditors" {
  name = "SecurityAuditors"
}

# Minimal permission that lets members  of the group assume the role
data "aws_iam_policy_document" "allow_assume_auditor_role" {
  statement {
    sid     = "AllowAssumeSecurityAuditorRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [aws_iam_role.security_auditor.arn]
  }
}

resource "aws_iam_policy" "assume_auditor_role" {
  name        = "AllowAssumeSecurityAuditorRole"
  description = "Permit sts:AssumeRole into SecurityAuditorRole"
  policy      = data.aws_iam_policy_document.allow_assume_auditor_role.json

  tags = {
    Project 	= "CloudSecurityLab"
    Environment = "Sandbox"
    Managedby	= "Terraform"
  }
}

resource "aws_iam_group_policy_attachment" "security_auditors_can_assume" {
  group      = aws_iam_group.security_auditors.name
  policy_arn = aws_iam_policy.assume_auditor_role.arn
}

# Adds the IAM user to the SecurityAuditors group so you can assume the role 
resource "aws_iam_user_group_membership" "security_auditors_membership" {
  user   = "tontrisha.griffin"
  groups = [aws_iam_group.security_auditors.name]
}