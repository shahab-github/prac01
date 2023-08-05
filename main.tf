resource "aws_instance" "nginx" {
  ami = var.ami
  instance_type = "t2.micro"
  key_name = "mykey01"
  vpc_security_group_ids = [aws_security_group.mysq.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    sudo systemctl enable nginx
    EOF
}

resource "aws_security_group" "mysq" {
  name = "nginx-sg"
#   vpc_id = ""

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}