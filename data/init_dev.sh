#!/bin/bash

set -eu -o pipefail

# development environment setup

# 1. timezone
sudo rm -v /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 2. install jdk krb5 client
sudo apt-get update
sudo apt-get --yes install ccache g++ gcc libffi-dev liblzo2-dev krb5-user ntp \
        ntpdate wget vim-common psmisc \
        lsof openjdk-8-jdk openjdk-8-source openjdk-8-dbg apt-utils git ant

# Don't use openjdk-8-jdk 8u181-b13-1ubuntu0.16.04.1 which is known to break the
# surefire tests. If we detect that version, we downgrade to the last known good one.
# See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911925 for details.
JDK_BAD_VERSION="8u181-b13-1ubuntu0.16.04.1"
if dpkg -l openjdk-8-jdk | grep -q $JDK_BAD_VERSION; then
    JDK_TARGET_VERSION="8u181-b13-0ubuntu0.16.04.1"
    DEB_DIR=$(mktemp -d)
    pushd $DEB_DIR
    wget --no-verbose \
        "https://launchpadlibrarian.net/380913637/openjdk-8-jdk_8u181-b13-0ubuntu0.16.04.1_amd64.deb" \
        "https://launchpadlibrarian.net/380913636/openjdk-8-jdk-headless_8u181-b13-0ubuntu0.16.04.1_amd64.deb" \
        "https://launchpadlibrarian.net/380913641/openjdk-8-jre_8u181-b13-0ubuntu0.16.04.1_amd64.deb" \
        "https://launchpadlibrarian.net/380913638/openjdk-8-jre-headless_8u181-b13-0ubuntu0.16.04.1_amd64.deb" \
        "https://launchpadlibrarian.net/380913642/openjdk-8-source_8u181-b13-0ubuntu0.16.04.1_all.deb" \
        "https://launchpadlibrarian.net/380913633/openjdk-8-dbg_8u181-b13-0ubuntu0.16.04.1_amd64.deb"
    sudo dpkg -i *.deb
    popd
    rm -rf $DEB_DIR
fi

# Download maven for all OSes, since the OS-packaged version can be
# pretty old.
if [ ! -d /usr/local/apache-maven-3.5.4 ]; then
  sudo wget -cnv \
    https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
  sha512sum -c - <<< '2a803f578f341e164f6753e410413d16ab60fabe31dc491d1fe35c984a5cce696bc71f57757d4538fe7738be04065a216f3ebad4ef7e0ce1bb4c51bc36d6be86 apache-maven-3.5.4-bin.tar.gz'
  sudo tar -C /usr/local -xzf apache-maven-3.5.4-bin.tar.gz
  sudo ln -s /usr/local/apache-maven-3.5.4/bin/mvn /usr/local/bin
fi

