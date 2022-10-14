    variable "instance_name" {
        description = "value of nametag for ec2"
        type= string
        
    }

    variable "key" {
        description = "name of aws key (pem)"
        type = string
        sensitive = true
    }

    variable "id" {
        description = "Security group ID"
        type = string
    }

     
