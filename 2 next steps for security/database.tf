data "aws_secretsmanager_secret_version" "<pickaname>" {
  # Fill in the name you gave to your secret
  secret_id = "<insert your id here>"
}


locals {
  db_creds = jsondecode(
    #Your secret name needs to be filled in below: <pickaname>
    data.aws_secretsmanager_secret_version.<pickaname>.secret_string
  )
}


resource "aws_db_instance" "database" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "lamp"
  username = local.db_creds.username
  password = local.db_creds.password
  db_subnet_group_name = aws_db_subnet_group.databasegroup.name
  parameter_group_name = "default.mysql5.7"
  /* availability_zone = data.aws_availability_zones.available.zone_ids[0] */
  vpc_security_group_ids = [aws_security_group.dbsg.id]
  skip_final_snapshot    = true
  identifier             = "lampdb"
  multi_az               = var.multi_az_db

  tags = merge({
    Name = "db-${terraform.workspace}"
  }, var.default_tags)
}


output "dburl" {
  value = aws_db_instance.database.address
}