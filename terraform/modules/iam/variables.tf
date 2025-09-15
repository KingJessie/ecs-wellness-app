variable "tags" {
  description = "Resource tag key-value pairs."
  type        = map(string)
  default     = {}
}

variable "project_name" {
  description = "The name of the project."
  type        = string
}