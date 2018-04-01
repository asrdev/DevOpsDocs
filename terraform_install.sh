sudo apt-get install unzip
wget  https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip
unzip terraform_0.11.5_linux_amd64.zip
mv terraform /usr/local/bin
rm terraform_0.11.5_linux_amd64.zip
terraform --version
