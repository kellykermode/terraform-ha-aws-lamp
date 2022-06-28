#The Region you want to deploy the infra
aws_region = "us-east-2"

# Replace the VPC cidr from your account. Range of CIDR max(22)
vpc_cidr = "172.31.0.0/16"

# Key pair name create in same region
key_name = "hakp"

# personal laptop public ip for debugging and SSH purpose
personal_laptop_ip = "68.37.94.95"