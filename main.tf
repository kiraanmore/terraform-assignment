module "network" {
    source = "./modules/network"
    vpc_cidr_block = var.vpc_cidr_block
    public_subnet_1 = var.public_subnet_1
    public_subnet_2 = var.public_subnet_2
    private_subnet_1 = var.private_subnet_1
    private_subnet_2 = var.private_subnet_2
}

module "security" {
    source = "./modules/security"
}

module "storage" {
    source = "./modules/storage"
    log-bucket-name = var.log-bucket-name
    kms-key-id = module.security.kms-key-id
}

module "compute" {
    source = "./modules/compute"
    public_key_path = var.public_key_path
    instance_type = var.instance_type
    log-bucket-name = var.log-bucket-name
    vpc-id = module.network.vpc-id
    public-subnet-1-id = module.network.public-subnet-1-id
    public-subnet-2-id = module.network.public-subnet-2-id
    private-subnet-1-id = module.network.private-subnet-1-id
    private-subnet-2-id = module.network.private-subnet-2-id
    lb-sg-id = module.network.lb-sg-id
    webserver-sg-id = module.network.webserver-sg-id
    bastion-sg-id = module.network.bastion-sg-id
}

#module "iam" {
#    source = "./modules/iam"
#    vpc_cidr_block = var.vpc_cidr_block
#    public_subnet_1 = var.public_subnet_1
#    public_subnet_2 = var.public_subnet_2
#    private_subnet_1 = var.private_subnet_1
#    private_subnet_2 = var.private_subnet_2
#}