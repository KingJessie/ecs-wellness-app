terraform {
  backend "s3" {
    bucket         = "wellness-5756895-tfstate"
    key            = "ecs-project/dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-lock-table"
    encrypt        = true
  }
}