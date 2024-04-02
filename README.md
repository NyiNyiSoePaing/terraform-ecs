## Terraform Script to Setup ECS
<!-- PROJECT LOGO -->

<div align="center">
    <img src="doc/devops.png" alt="Logo" width="180" height="80">
  </a>

  <h3 align="center">Amazon Elastic Container Service</h3>

  <p align="center">
    Terraform template to Setup ECS Architecture!
    <br />
    <br />
  </p>
</div>

# Table of Contents


1. [Setting AWS Profile](#setting-aws-rofile)

2. [Deployment](#deployment)

### Setting AWS Profile

To configure your AWS profile for using this Terraform script, you have two options:

1. **Export AWS Profile (Recommended):**
   
   Execute the following command in your terminal to export the AWS profile:

   ```bash
   export AWS_DEFAULT_PROFILE=nyinyisoepaing
   ```

> :bulb: **Tip:** Replace <b>nyinyisoepaing</b> with your AWS profile name.

2. **Set AWS Profile in var.tf and provider.tf Files**


   <b>Alternatively</b>, you can set the AWS profile directly within the var.tf and provider.tf file. 
   - Update the aws_credentials variable with your AWS access key and secret key:

   ```bash
   # variable.tf
    variable "aws_credentials" {
      type = object({
        access_key = string
        secret_key = string
      })

      default = {
        access_key = "your_access_key"
        secret_key = "your_secret_key"
      }
    }

   # provider.tf
   provider "aws" {
        region = var.aws_region
        access_key = var.access_key
        secret_key = var.secret_key
    }

> :bulb: **Tip:** Replace "your_access_key" and "your_secret_key" with your AWS access key and secret key respectively.

> :warning: **Warning:** Make sure that the AWS profile you use has the necessary permissions to create and manage ECS resources.

## Deployment

#### Update Variables: 
- Before initiating the deployment process, ensure that all variables in your <b>var.tf</b> file are updated with the appropriate values. 
- This includes variables such as AWS credentials, region, and any other parameters needed for your infrastructure.

#### Initialize Terraform: 

```bash
terraform init
```
#### Generate Execution Plan:

```bash
terraform plan
```
#### Validation and Apply Changes:
```bash
terraform validate && terraform apply
```

#### CleanUp:
```bash
terraform destroy
```