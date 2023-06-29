
# Create EC2 instance

resource "aws_instance" "tjc_ec2" {
  ami = "ami-022e1a32d3f742bd8"
  instance_type = var.ec2size
  key_name = var.keyName

  vpc_security_group_ids = [aws_security_group.toms-sg.id]


  tags = {Name = "Terraform EC2"}

  # Copy in the bash script we want to execute.
  provisioner "file" {
    source      = "~/setup-ec2.sh"
    destination = "/tmp/setup-ec2.sh"
  }

  # Change permissions on bash script and execute from ec2-user.
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup-ec2.sh",
      "sudo /tmp/setup-ec2.sh",
    ]
  }



  # Login to the ec2-user with the aws pem key.
  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    private_key = file(var.keyPath)
    host        = self.public_ip
  }


}