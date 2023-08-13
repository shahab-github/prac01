resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user" "user" {
  name = "test-user"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  users      = [aws_iam_user.user.name]
#   roles      = [aws_iam_role.role.name]
#   groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.policy.arn
}

##################################################################################################

resource "aws_iam_user" "user01" {
  name = "terraformuser"
}


resource "aws_iam_user_policy" "userpolicy" {
  name = "terraform-user-ploicy"
  user = aws_iam_user.user01.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
