############################################################
# Example Auditor Role (assumable with MFA by this account)
############################################################

locals {
  account_id = "123456789012"
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

resource "aws_iam_role" "example_auditor" {
  name               = "ExampleAuditorRole"
  assume_role_policy = data.aws_iam_policy_document.auditor_trust.json

  tags = {
    Project     = "CloudSecurityLab"
    Environment = "Sandbox"
    Owner       = "example.owner"
    ManagedBy   = "Terraform"
  }
}

# Attach AWS-managed read-only policies suitable for auditing
resource "aws_iam_role_policy_attachment" "auditor_securityaudit" {
  role       = aws_iam_role.example_auditor.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy_attachment" "auditor_readonly" {
  role       = aws_iam_role.example_auditor.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

############################################################
# Group allowed to assume the role + permissions + membership
############################################################

resource "aws_iam_group" "example_auditors" {
  name = "ExampleAuditors"
}

# Minimal permission that lets members of the group assume the role
data "aws_iam_policy_document" "allow_assume_example_auditor" {
  statement {
    sid     = "AllowAssumeExampleAuditorRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [aws_iam_role.example_auditor.arn]
  }
}

resource "aws_iam_policy" "assume_example_auditor" {
  name        = "AllowAssumeExampleAuditorRole"
  description = "Permit sts:AssumeRole into ExampleAuditorRole"
  policy      = data.aws_iam_policy_document.allow_assume_example_auditor.json

  tags = {
    Project     = "CloudSecurityLab"
    Environment = "Sandbox"
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_group_policy_attachment" "example_auditors_can_assume" {
  group      = aws_iam_group.example_auditors.name
  policy_arn = aws_iam_policy.assume_example_auditor.arn
}

# Adds the IAM user to the ExampleAuditors group
resource "aws_iam_user_group_membership" "example_auditor_membership" {
  user   = "example.user"
  groups = [aws_iam_group.example_auditors.name]
}
