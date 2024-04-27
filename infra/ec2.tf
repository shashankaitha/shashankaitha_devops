data "aws_ami" "tekyz_ami" {
  most_recent = true
  name_regex  = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240423"
  owners      = ["099720109477"]
}

data "aws_iam_role" "tekyz_iam_role" {
  name = "Admin_role"
}


resource "aws_instance" "tekyz_demo" {
  ami           = data.aws_ami.tekyz_ami.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  # iam_instance_profile        = data.aws_ami.tekyz_ami.name
  iam_instance_profile        = "Admin_role"
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
    curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.3/2024-04-19/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
    echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
    sudo install -o root -g root -m 0777 kubectl /usr/local/bin/kubectl
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    wget https://releases.hashicorp.com/terraform/1.8.2/terraform_1.8.2_linux_amd64.zip
    sudo unzip terraform_1.8.2_linux_amd64.zip -d /usr/local/bin
    sudo apt install git-all
  EOF

}

# minikube start --force

