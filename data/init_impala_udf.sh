#!/bin/bash

# add cloudera source
sudo mv cloudera.list /etc/apt/sources.list.d/

wget -qO - https://archive.cloudera.com/cdh6/6.2.0/ubuntu1604/apt/archive.key | sudo apt-key add -

# install https support
sudo apt-get install apt-transport-https
# install cmake libboost-dev
sudo apt-get install libboost-dev cmake

# update source
sudo apt-get update
# install impala udf
sudo apt-get install impala-udf-dev
