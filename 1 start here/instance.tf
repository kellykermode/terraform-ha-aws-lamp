/*#data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}*/


resource "aws_instance" "lampsetup" {
  count                       = var.az_count
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.websubnets[count.index % var.az_count].id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.websg.id]
  associate_public_ip_address = true


  root_block_device {
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
    volume_type           = "gp2"

    tags = merge({
      Name = "rootVolume-${count.index}-${terraform.workspace}"
    }, var.default_tags)
  }

  user_data = <<-EOF
      #!/bin/sh
      sudo yum update -y
      sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
      sudo yum install -y httpd mariadb-server
      sudo systemctl start httpd
      sudo systemctl enable httpd
      sudo usermod -a -G apache ec2-user
      sudo chown -R ec2-user:apache /var/www
      sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
      find /var/www -type f -exec sudo chmod 0664 {} \;
      sudo echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
      EOF


  tags = merge({
    Name = "Lamp-${count.index}-${terraform.workspace}"
  }, var.default_tags)
}