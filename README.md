# terraform-assignment

This terraform assignment creates following resources :
- Network components : VPC, Subnets, IGW, NAT gateway, Route Table, NACL
- Compute components : ALB, Target Groups, ASG, LC
- Storage components : S3
- Security components : KMS

Steps to execute :
1. Clone the git repository. 
2. Generate SSH key pairt using below command :
*ssh-keygen -f ssh-key*
3. Update the variables in *variables.tf* file located in root of repository.
4. Run command : terraform init
5. Run command : terraform apply
6. Type *yes* when prompted.

Assignment is divided into modules for Network, Compute and Storage components. Executing it from root of the repository will execute *main.tf* which invokes other modules.