#!/bin/bash

sudo apt -y update
sudo apt -y upgrade

#INSTALL DEPENDENCIES USED AND TOOLS
sudo apt install -y libcurl4-openssl-dev
sudo apt install -y libssl-dev
sudo apt install -y jq
sudo apt install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt install -y build-essential libssl-dev libffi-dev python-dev
sudo apt install -y python-setuptools
sudo apt install -y libldns-dev
sudo apt install -y python3-pip
sudo apt install -y python-pip
sudo apt install -y python-dnspython
sudo apt install -y git
sudo apt install -y rename
sudo apt install -y xargs
sudo apt install -y nmap


# Install httpie
sudo apt install httpie


# Install GO

if [[ -z "$GOPATH" ]]
then
    echo "Go is not installed. Installation in process..."
    sudo apt install golang-go
    sudo mv go /usr/local
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
    echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
    echo 'export GOPATH=$HOME/go'	>> ~/.bash_profile			
    echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bash_profile	
    source ~/.bash_profile
    sleep 1
fi

# Installing to in opt
cd /opt

echo "Installing JSParser"
sudo git clone https://github.com/nahamsec/JSParser.git
cd JSParser*
sudo python setup.py install
cd ..
sudo ln -s /opt/JSParser /usr/bin/JSParser


echo "Installing dirsearch"
sudo git clone https://github.com/maurosoria/dirsearch.git
sudo ln -s /opt/dirsearch /usr/bin/dirsearch

echo "installing httprobe"
sudo go get -u github.com/tomnomnom/httprobe 
echo "done"

echo "Installing waybackurls"
sudo git clone https://github.com/tomnomnom/waybackurls.git
cd waybackurls
sudo go build main.go
sudo ln -s /opt/waybackurls/main /usr/bin/waybackurls

echo "Installing jwt_tool"
sudo git clone https://github.com/ticarpi/jwt_tool
cd jwt_tool
python3 -m pip install termcolor cprint pycryptodomex requests
sudo chmod +x jwt_tool.py
sudo ln -s /opt/jwt_tool/jwt_tool.py /usr/bin/jwt_tool


echo "downloading Seclists"
cd /
mkdir wordlists
git clone https://github.com/danielmiessler/SecLists.git
cd ~/wordlists/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd /opt
echo "done"


echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up"
ls -la
