data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_auditor_trust" {
  statement {
    sid     = "AllowMFAOnly"
    actions = ["sts:AssumeRole"]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "s3_auditor" {
  name               = "S3AuditorRole"
  assume_role_policy = data.aws_iam_policy_document.s3_auditor_trust.json
}

resource "aws_iam_role_policy_attachment" "s3_auditor_readonly" {
  role       = aws_iam_role.s3_auditor.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_group" "s3_auditors" {
  name = "S3Auditors"
}

resource "aws_iam_user_group_membership" "s3_auditors_membership" {
  user   = "tontrisha.griffin"                # must already exist
  groups = [aws_iam_group.s3_auditors.name]
}
