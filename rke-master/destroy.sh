# cleanup
#export TF_LOG=DEBUG
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_REGION="eu-west-3"
#read -p "press enter to continue"
terraform destroy -auto-approve 2>&1 | tee destroy.log