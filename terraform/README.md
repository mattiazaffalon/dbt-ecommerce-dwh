Create a file named "terraform.tfvars" in this folder, and provide a value for each variable mentioned in *variables.tf*.

Execute the following commands>

```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```
