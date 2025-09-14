# Security Group allowing minimal exposure
resource "aws_security_group" "nodes" {
  name        = "${local.name}-sg"
  description = "Security group for Ansible lab nodes"
  vpc_id      = aws_vpc.this.id
  tags        = merge(local.tags, { Name = "${local.name}-sg" })

  # SSH from specified CIDR (narrow this to your IP if possible)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr]
  }

  # HTTP to LB and Web from anywhere (for testing)
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow intra-cluster traffic (all ports) within SG
  ingress {
    description     = "intra-cluster"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    self            = true
  }

  # Allow ingres to mysql from anywhere lol
  ingress {
    description = "iamanidiot"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}