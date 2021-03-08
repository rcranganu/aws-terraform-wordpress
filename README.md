[![MIT license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
![GitHub issues](https://img.shields.io/github/issues/rcranganu/aws-terraform-wordpress)

> **This is still in Work in Progress**
> 
> **Anyone that wants to join as a contributor is WELCOMED**

# AWS Terraform WordPress
The poupose of this project is to build the infrastructure to build and deploy a fully working instance of WordPress in AWS.

> Please check [CHANGELOG](CHANGELOG.md) for features and/or bug fixes.

## Structure of project
* **Environments**
  * _**Sandbox**_ - this is your standard development env.
  * _**UAT**_ - this is going to be your UAT/Testing env.
  * _**Prod**_ - this is going to be your Production end
* **Files**
  * _**policies**_ - we will keep this folder to add JSON policies for IAM mostly
* Modules
  * We will going to keep in this folder all Terraform modules
  * Modules naming convencitons:
    * _module name_ - is going to be used for the **sandbox** environment
    * _module name_**_uat**_ - is going to be used for the **uat/test** environment
    * _module name_**_prod**_ - is going to be used for the **production** environment

## Arhitecture
All the arhictures are based on AWS WordPress deployments best practices.

### Sandbox / Development environment

## Authors
The project is managed by [Razvan Cranganu](https://github.com/rcranganu)

## License
MIT Licensed. See [LICENSE](LICENSE) for full details.