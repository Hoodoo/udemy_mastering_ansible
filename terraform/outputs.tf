output "lb_public_ip"      { value = aws_instance.lb.public_ip }
output "web_public_ip"     { value = aws_instance.web.public_ip }
output "db_public_ip"      { value = aws_instance.db.public_ip }

output "ssh_private_key_path" {
  value       = "${path.module}/id_rsa"
  description = "Private key for SSH (stored locally)"
  sensitive   = true
}

output "ansible_inventory" {
  value       = "${path.module}/../ansible/inventory.ini"
  description = "Path to generated Ansible inventory"
}