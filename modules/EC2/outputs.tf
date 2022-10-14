output "instance_private_ip_addr" {
    value = aws_instance.server.private_ip
}

output "instance_public_ip_addr" {
    value = aws_instance.server.public_ip
}
