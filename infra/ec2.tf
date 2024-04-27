data "aws_ami" "tekyz_ami" {
  most_recent = true
  name_regex  = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240423"
  owners      = ["099720109477"]
}


resource "aws_instance" "tekyz_demo" {
  ami                         = data.aws_ami.tekyz_ami.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size           = "20"
    volume_type           = "gp3"
    delete_on_termination = true
  }
  # security_groups             = var.security_group_id
  tags = {
    Name              = "${var.project_name}-minikube"
    Terraform-Managed = "Yes"
    Env               = "dev"
    Projectname       = "1234"
  }
  user_data = <<-EOF
  	#!/bin/bash
    sudo apt update && apt upgradeterraform_1.8.2_linux_386.zip
    curl -fsSL https://get.docker.com -o install-docker.sh
    chmod 755 install-docker.sh
    sudo apt install unzip
    sh install-docker.sh
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    curl -LO https://releases.hashicorp.com/terraform/1.8.2/terraform_1.8.2_linux_386.zip -o terraform_1.8.2_linux_386.zip
    unzip terraform_1.8.2_linux_386.zip
    sudo apt update && sudo apt install terraform
    sudo apt install git-all
  EOF

}
