resource "aws_instance" "tr-task" {
  ami                    = "ami-0c858d4d1feca5370"
  instance_type          = "t3.micro"
  availability_zone      = "eu-north-1a"
  key_name               = "TF_key"
  subnet_id              = aws_subnet.subnet-1.id
  vpc_security_group_ids = [aws_security_group.allow_web.id]

  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${local_file.TF-key.filename}")
      host        = aws_instance.tr-task.public_ip
    }


    inline = [
      "sudo yum install -y python3-pip python3-devel gcc",
      "sudo pip3 install ansible",
      "mkdir -p /tmp/ansible",
      "echo '${file("playbook.yml")}' > /tmp/ansible/playbook.yml",
      "ansible-playbook /tmp/ansible/playbook.yml"
    ]
  }


  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "run_ansible" {
  depends_on = [aws_instance.tr-task]

}
