#!/bin/bash


#-------------------------------------------------------
sudo yum install git wget -y
sudo yum install vim -y
sudo yum install automake -y
sudo yum install tree -y

#-------------------------------------------------------
GO_VERSION=1.7.1
BASH_CONFIG=/home/vagrant/.bash_profile
GOPATH=/vagrant/gocode

#-------------------------------------------------------
_command_exists() {
  command -v "$@" > /dev/null 2>&1
}

echo "#CHECK-GO: Ensure golang is installed"
_command_exists go || {

echo "#DOWNLOAD-GO-BINARY: Downloading go${GO_VERSION}.linux-amd64.tar.gz"
wget -c --progress=bar https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz 2>&1 \
                  | grep --line-buffered "%" \
                                | sed -u -e "s,\.,,g"
  echo '#UPACK-GO-BINARY: Unpacking go language'
  sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
  rm go${GO_VERSION}.linux-amd64.tar.gz
  ln -s $GOPATH $HOME
}
echo -e "OK!"
#-------------------------------------------------------

echo "#CHECK-ENV: Ensure golang env related variables are present"
_command_exists go || {

  echo '#CONFIGURE-GO: Ensure env variables'
  echo "export GOPATH=$GOPATH" >> $BASH_CONFIG
  echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> $BASH_CONFIG

}
echo -e "OK!"

#-------------------------------------------------------
echo "#CHECK-ENV: Ensure PS1 env related variables are present"
cat $BASH_CONFIG | grep 'export PS1="\\n\\\['  > /dev/null || {

  echo '#CONFIGURE-PS!: Ensure env Variables'
  echo 'export PS1="\n\[\e[1;37;42m\] \u \[\e[0m\] \[\e[0;31m\]\!:\[\e[0m\]\w\[\e[0;31m\]:\[\e[0m\] "' >> $BASH_CONFIG

 }
 echo -e "OK!"

#-------------------------------------------------------
