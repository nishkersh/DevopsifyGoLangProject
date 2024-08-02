#!/bin/bash

sudo apt update && sudo apt upgrade
sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
source ~/.bashrc

go version
go run testfile.go
