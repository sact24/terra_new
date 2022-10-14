provider "aws" {
  region  = "ap-south-1"
}


module "EC2" {
  source = "../../modules/EC2"

//adding variables defined in root module
  instance_name = "test"
  key = "test"
}


output "IP" {
  value = module.EC2
}
