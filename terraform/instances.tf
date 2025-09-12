# Common bits for all nodes
locals {
  common_user_data = <<-EOT
    #cloud-config
    package_update: true
    package_upgrade: false
    ssh_pwauth: false
  EOT
}

resource "aws_instance" "control" {
  ami                         = local.ubuntu_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  user_data = <<-EOT
    #cloud-config
    hostname: control
    ${local.common_user_data}
  EOT

  tags = merge(local.tags, { Name = "${local.name}-control", Role = "control" })
}

resource "aws_instance" "lb" {
  ami                         = local.ubuntu_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  user_data = <<-EOT
    #cloud-config
    hostname: lb
    ${local.common_user_data}
  EOT

  tags = merge(local.tags, { Name = "${local.name}-lb", Role = "lb" })
}

resource "aws_instance" "web" {
  ami                         = local.ubuntu_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  user_data = <<-EOT
    #cloud-config
    hostname: web
    ${local.common_user_data}
  EOT

  tags = merge(local.tags, { Name = "${local.name}-web", Role = "web" })
}

resource "aws_instance" "db" {
  ami                         = local.ubuntu_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = true

  user_data = <<-EOT
    #cloud-config
    hostname: db
    ${local.common_user_data}
  EOT

  tags = merge(local.tags, { Name = "${local.name}-db", Role = "db" })
}

resource "local_file" "inventory" {
  filename        = "${path.module}/../ansible/inventory.ini"
  content = templatefile("${path.module}/templates/inventory.tmpl", {
    control_ip = aws_instance.control.public_ip
    lb_ip      = aws_instance.lb.public_ip
    web_ip     = aws_instance.web.public_ip
    db_ip      = aws_instance.db.public_ip
    ssh_user   = "ubuntu"
    key_path   = "${path.module}/id_rsa"
  })
  file_permission = "0644"
}