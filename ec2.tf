data "aws_ami" "tekyz_ami" {
  most_recent = true
  name_regex  = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240423"
  owners      = ["099720109477"]
}


resource "aws_instance" "tekyz_demo" {
  ami                         = data.aws_ami.tekyz_ami.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = var.security_group_id
  tags = {
    Name              = "${var.project_name}-minikube"
    Terraform-Managed = "Yes"
    Env               = "dev"
    Projectname       = local.project_id
  }

}
