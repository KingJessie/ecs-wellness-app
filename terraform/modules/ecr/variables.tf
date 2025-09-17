variable "project_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {
    Name        = "ecr-repo",
    Environment = "dev"
  }
}
