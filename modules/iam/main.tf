resource "aws_iam_policy" "policy_bastion" {
  name        = "cs-iam-policy-${var.environment}-bastionec2"
  path        = "/"
  description = "IAM Policy for Bastion EC"
  policy      = file("../../files/policies/iam-policy-sandbox-bastion.json")
}

resource "aws_iam_role" "bastion_role" {
  name               = "cs-iam-role-${var.environment}-bastionec2"
  assume_role_policy = file("../../files/policies/iam-role-sandbox-bastion.json")
  tags = {
    Name      = "cs-iam-role-${var.environment}-bastionec2"
    CreatedBy = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "bastion_attach_policy" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.policy_bastion.arn
}
