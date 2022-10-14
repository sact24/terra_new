terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


// use existing SG from AWS account (we can also create a new sg using terraform)
data "aws_security_group" "mysg"{
  id= var.id
}

//creating key
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// use -var to specify key name
resource "aws_key_pair" "kp" {
  key_name   = var.key       # Create a "key" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh
}

//saving pem locally
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.kp.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
  file_permission = 400
}

resource "aws_instance" "server" {
  
  ami           = "ami-068257025f72f470d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.mysg.id]
  key_name = aws_key_pair.kp.id

  //user_data = file("./userdata_tomcat.sh") 
 
  tags = {
    Name = var.instance_name
  }
}

