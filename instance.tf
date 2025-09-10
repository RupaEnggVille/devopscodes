resource "aws_instance" "WebServer" {
  ami                    = var.amiID[var.region]
  instance_type          = "t3.micro"
  key_name               = "dev-key"
  subnet_id              = aws_subnet.dev-pub-1.id
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  availability_zone      = var.zone1

  tags = {
    Name    = "Dev-WebServer"
    Project = "DevOps"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
    type        = "ssh"
    user        = var.webuser
    private_key = file("devkey")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}


resource "aws_ec2_instance_state" "WebServer-State" {
  instance_id = aws_instance.WebServer.id
  state       = "running"
}

output "WebServerPublicIP" {
  description = "publicIP of Ubuntu instance"
  value       = aws_instance.WebServer.public_ip
}
output "WebServerPrivateIP" {
  description = "privateIP of Ubuntu instance"
  value       = aws_instance.WebServer.private_ip
}