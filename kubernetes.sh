##########   Basic installs to start the kubernetes setup: #####################################
apt update
apt upgrade -y
apt install python-pip -y
pip --version
pip install awscli
pip install --upgrade pip
aws --version
#Note: aws configure need to be completed to perform s3, route53 or any addition on aws. Moreover this account should require to 
#################    Install Kubectl client: #########################################################
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version
#################    Install kops client: #########################################################
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops
kops version
#################   Create S3 Bucket      #########################################################
aws s3 mb s3://clusters.manic.com
#Expose environment variable:
export KOPS_CLUSTER_NAME=clusters.manic.com
echo $KOPS_CLUSTER_NAME
export KOPS_STATE_STORE=s3://clusters.manic.com
echo $KOPS_STATE_STORE
ssh-keygen -t rsa -C "manee2k6@gmail.com"

################   Kubernetes cluster creation using KOPS    ######################################################
aws route53 create-hosted-zone --name clusters.manic.com --caller-reference 1
kops create cluster \
--cloud=aws \
--master-count=1 \
--master-size=t2.medium \
--node-count=2 \
--node-size=t2.medium \
--zones=us-east-2a \
--name=${KOPS_CLUSTER_NAME}
kops update cluster
kops update cluster --yes


