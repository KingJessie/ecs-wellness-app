resource "aws_ecr_repository" "private_ecr" {
  name                 = "${var.project_name}-repoisitory"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}