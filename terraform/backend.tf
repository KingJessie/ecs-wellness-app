terraform {
  backend "s3" {
    bucket         = "defectdojo-dev-tfstate"
    key            = "ecs-project/dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "defectdojo-lock-table"
    encrypt        = true
  }
}
