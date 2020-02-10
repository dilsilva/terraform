# Terraform implementations

This is a implementation of an AWS VPC that provides an EC2 instance with a custom NGINX page running in a DOCKER container exposed through a ELB.

The objective is to quickly achieve the 'MVP' and show some functional content, using the AWS enviroment through infraestructure as a code.
This implementation follows the JUVO technical interview requierements.

## Instructions

After running `aws configure` in order to setup your AWS account, simple run a `terraform init` to initiate the modules, then a `terraform apply` to implementate the whole infrastructure from zero.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
