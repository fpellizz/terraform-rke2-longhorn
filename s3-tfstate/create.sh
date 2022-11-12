export TF_LOG=DEBUG
# initialize terraform configuration
terraform init 2>&1 | tee init.log
read -p "press enter to continue"
# validate terraform configuration
terraform validate 2>&1 | tee validate.log
read -p "press enter to continue"
# create terraform plan
terraform plan -out state.tfplan 2>&1 | tee plan.log
read -p "press enter to continue"
# apply terraform plan
terraform apply state.tfplan 2>&1 | tee apply.log
read -p "press enter to continue"
# write terraform output on file
terraform output > terraform_outputs.file