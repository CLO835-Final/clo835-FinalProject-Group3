echo "Create IRSA Service Account" 
#Get oidc
eksctl utils associate-iam-oidc-provider --cluster finalproject --approve
set -x

sleep 5

echo "display oidc"
aws eks describe-cluster --name  group3 --query cluster.identity.oidc.issuer --output text

sleep 5

echo "create service account with IAM role and policy attached"
eksctl create iamserviceaccount     --name clo835     --namespace final     --cluster finalproject     --attach-policy-arn arn:aws:iam::616865343531:policy/s3-restricted-read     --approve     --override-existing-serviceaccounts;
set -x