output "publicip" {
  value = aws_instance.nginx.public_ip
}