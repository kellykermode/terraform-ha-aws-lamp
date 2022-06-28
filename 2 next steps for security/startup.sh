#!/bin/bash
      sudo yum update -y
      sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
      sudo yum install -y httpd mariadb-server
      sudo systemctl start httpd
      sudo systemctl enable httpd
      # allows ec2-user to access the web server
      sudo usermod -a -G apache ec2-user
      # assigns the web server to the ec2-user
      sudo chown -R ec2-user:apache /var/www
      sudo echo "Hello, World!" > index.html
      sudo echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php