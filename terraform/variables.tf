variable "aws_region" {
  description = "AWS region for the lab"
  type        = string
  default     = "eu-west-2" # London
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "ansible-lab"
}

variable "ssh_ingress_cidr" {
  description = "CIDR allowed to SSH (use your IP/32 ideally)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  description = "EC2 instance type for all nodes"
  type        = string
  default     = "t3.micro"
}

variable "ubuntu_owner" {
  description = "Canonical's AWS account ID"
  type        = string
  default     = "099720109477"
}

variable "ubuntu_name_pattern" {
  description = "Ubuntu 24.04 LTS AMD64 HVM SSD"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"
}

variable "aws_profile" {
  description = "AWS profile name"
  type        = string
  default     = "lab-personal"
}