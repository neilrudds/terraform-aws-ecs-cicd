variable "project_name" {
  default     = "tf01"
  description = "Project Name"
  type        = string
}

variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region"
  type        = string
}

variable "availability_zones" {
  default     = ["us-east-1a", "us-east-1b"]
  description = "Availability Zones"
  type        = list(string)
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR"
  type        = string
}

variable "public-subnet-1_cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet 1 CIDR"
  type        = string
}

variable "public-subnet-2_cidr" {
  default     = "10.0.2.0/24"
  description = "Public Subnet 2 CIDR"
  type        = string
}

variable "private-subnet-1_cidr" {
  default     = "10.0.3.0/24"
  description = "Private Subnet 1 CIDR"
  type        = string
}

variable "private-subnet-2_cidr" {
  default     = "10.0.4.0/24"
  description = "Private Subnet 2 CIDR"
  type        = string
}

variable "log_retention_days" {
  default     = 7
  description = "ECS CloudWatch logs retention (days)"
  type        = number
}

variable "app_port" {
  default     = 8080
  description = "Backend application port"
  type        = number
}

variable "task_cpu" {
  default     = 1024
  description = "CPU units for the task (256, 512, 1024, 2048, 4096)"
  type        = number
}

variable "task_memory" {
  default     = 2048
  description = "Memory (MB) for the task"
  type        = number
}

variable "app_name" {
  default     = "nodeweb01"
  description = "Application name"
  type        = string
}

variable "min_capacity" {
  default     = 1
  description = "Min. number of task instances"
  type        = number
}

variable "max_capacity" {
  default     = 10
  description = "Max. number of task instances"
  type        = number
}