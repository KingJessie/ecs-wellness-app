resource "aws_ecr_repository" "this" {
  name                 = "${var.project_name}-repository"
  image_tag_mutability = "IMMUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}