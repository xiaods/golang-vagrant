# might not need sudo here if you run this as privileged in Vagrantfile
sudo yum update
sudo yum install git -y
sudo yum install go -y
sudo yum install vim -y

BASH_CONFIG=/home/vagrant/.bash_profile
GOPATH=/home/vagrant/dev
PATH=$PATH:/usr/local/go/bin
echo "#CHECK-ENV: Ensure golang env related variables are present"
echo > $BASH_CONFIG
echo "export GOPATH=$GOPATH" >> $BASH_CONFIG
echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> $BASH_CONFIG

echo "install golang tools: godep"
go get github.com/tools/godep
