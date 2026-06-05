variable "region" {
  default = "us-east-1"
}

variable "vpc_id" {
  default = "vpc-02c08bfa1a83d4a33"
}

variable "public_subnet_ids" {
  default = "subnet-0f1e47afeb7854766"
}

variable "ami_id" {
  default = "ami-080e1f13689e07408"
}

variable "key_name" {
  default = "jenkins-kp"
}
variable "environment" {
  description = "Deployment environment (dev | staging | prod)."
  type        = string
  validation {
    condition     = contains(["dev", "test", "production"], var.environment)
    error_message = "environment must be one of: dev, test, production."
  }
}
