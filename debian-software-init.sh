#!/bin/env bash


# Basic tools I always want
sudo apt-get -y install git
sudo apt-get -y install screen
sudo apt-get -y install aptitude curl 
sudo apt-get -y install vim-gnome#
sudo apt-get -y install tmux

# Starting package for core development tasks
sudo apt-get -y install build-essential fakeroot dpkg-dev
sudo apt-get -u install linux-headers-$(uname -r)

# Add scala syntax checking for vim

mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do curl -o ~/.vim/$d/scala.vim https://raw.github.com/scala/scala-dist/master/tool-support/src/vim/$d/scala.vim; done

./jvm-debian-init.sh

./python-debian-init.sh


#wget -c 'http://sourceforge.net/projects/boost/files/boost/1.50.0/boost_1_50_0.tar.bz2/download'
#tar xf download
#cd boost_1_50_0
#./bootstrap.sh
#./b2 install


# final fun stuff
#
# WARNING:  I have been keeping the latest release build for 0MQ in /opt 
# via manual download and build and this version is what is loaded into 
# the default shell, but then an use apt-get for the python bindings and 
# /usr/lib libraries.  This could introduce problems, but hasn't yet.  
# Should be tweaked to download latest python binding source code and build 
# against production libraries  (see dev-env.sh) 

sudo apt-get -y install libzmq-dev
pip install tornado pygments pyzmq

# Lastly install common JVM libraries

groovy -Dgrape.root=$GRAPE_STAGING jvm-libs.groovy 



