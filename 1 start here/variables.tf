variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "vpc_cidr" {
  type = string
}

variable "az_count" {
  type    = number
  default = 2
}

variable "default_tags" {
  type = map(any)
  default = {
    "company_name" : "myCompany"
    "business_unit" : "application_dev"
    "support_email" : "support@example.com"
  }
}

variable "ami" {
  default = "ami-02d1e544b84bf7502"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "hakp"
}

variable "root_volume_size" {
  type    = string
  default = "30"
}

variable "multi_az_db" {
  type    = bool
  default = true
}

variable "personal_laptop_ip" {
  type    = string
  default = "68.37.94.95" #switch to your own IP address
}