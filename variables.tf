variable "aws_region" {    
    default = "ap-south-1"
}

variable "vpc_cidr_block" {    
    default = "10.0.0.0/16"
}

variable "public_subnet_1" {    
    default = "10.0.1.0/24"
}

variable "public_subnet_2" {    
    default = "10.0.2.0/24"
}

variable "private_subnet_1" {    
    default = "10.0.3.0/24"
}

variable "private_subnet_2" {    
    default = "10.0.4.0/24"
}

variable "log-bucket-name" {    
    default = "terraform-assignment-log-bucket-1"
}

variable "public_key_path" {
    default = "./ssh-key.pub"
}

variable "instance_type" {    
    default = "t2.micro"
}