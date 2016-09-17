#!/bin/bash
exit

/bin/echo "*** Installing profile .."

/usr/bin/rm -fr ~/.vim/bundle

if [ ! `rpm -qa httpie` ]; then
  /usr/bin/sudo yum install httpie -y
fi;

if [ ! `rpm -qa npm` ]; then
  /usr/bin/sudo yum install npm -y
fi;

if [ `rpm -qa npm` ] && [ ! `npm view -g jshint version 2>/dev/null` ]; then
  /usr/bin/sudo npm install -g jshint
fi;

/bin/cp -uvaR .bash-completions ~/
/bin/cp -uvaR .vim ~/
/bin/cp -uva .vimrc ~/
/bin/cp -uva .bashrc ~/
/bin/cp -uva .bash_profile ~/
/bin/cp -uva .bash_logout ~/
/bin/cp -uva .pogoconf ~/
/bin/cp -uva .gitconfig ~/
/bin/cp -uva .xsessionrc ~/

source ~/.bashrc

# Install go
/bin/echo "*** Installing Go .."
GO=/usr/local/bin/go

# if [ ! -x $GO ]; then
  /usr/bin/mkdir -p $HOME/go

  GO_VERSION=1.4.1
  GO_SHA1_CHECKSUM=3e871200e13c0b059b14866d428910de0a4c51ed
  cd /tmp/
  curl -L -O http://edge.artifactory.yahoo.com:8000/artifactory/simple/platform_rpms_test/go$GO_VERSION.linux-amd64.tar.gz
  sudo tar xzf /tmp/go$GO_VERSION.linux-amd64.tar.gz -C /usr/local/
  /usr/bin/rm /tmp/go$GO_VERSION.linux-amd64.tar.gz
  sudo chmod 755 /usr/local/go

  if [ ! -L /usr/local/bin/go ]; then
    sudo ln -s /usr/bin/go    /usr/local/bin/go
    sudo ln -s /usr/bin/godoc /usr/local/bin/godoc
    sudo ln -s /usr/bin/gofmt /usr/local/bin/gofmt
  fi
  
  /bin/echo "*** Go environment .."
  $GO env

  # Install tools
  # See yo/go.platform
  /bin/echo "*** Installing Go tools .."
  GOPATH=$HOME/go $GO get -v github.com/golang/lint/golint
  GOPATH=$HOME/go $GO get -v github.com/kisielk/errcheck
  GOPATH=$HOME/go $GO get -v github.com/tools/godep
  GOPATH=$HOME/go $GO get -v golang.org/x/tools/cmd/stringer
  GOPATH=$HOME/go $GO get -v golang.org/x/tools/cmd/...
  GOPATH=$HOME/go $GO get -v github.com/onsi/ginkgo/ginkgo
  GOPATH=$HOME/go $GO get -v github.com/onsi/gomega

  /bin/echo "*** Installed the following Go tools: "
  ls -l $HOME/go/bin
# fi

/bin/echo "***"

