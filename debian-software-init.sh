

# Add repository for oracle's java 
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update

# Basic tools I always want
sudo apt-get -y install aptitude curl 
sudo apt-get -y install vim-gnome#

# Add scala syntax checking for vim

mkdir -p ~/.vim/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do curl -o ~/.vim/$d/scala.vim https://raw.github.com/scala/scala-dist/master/tool-support/src/vim/$d/scala.vim; done


# Remove Open JDK Java 
sudo apt-get purge openjdk-\* 

# Add real-world Java
sudo apt-get -y install oracle-java6-installer
sudo apt-get -y install oracle-java7-installer

# Install groovy environment manager for graddle etc...
sudo curl -s get.gvmtool.net | bash

# initial GMV
source ~/.gvm/bin/gvm-init.sh

# Install Boost libraries
#wget -c 'http://sourceforge.net/projects/boost/files/boost/1.50.0/boost_1_50_0.tar.bz2/download'
#tar xf download
#cd boost_1_50_0
#./bootstrap.sh
#./b2 install

# Install PIP and python-dev

sudo apt-get -y install python-dev python-pip

# install python virtual environment manager 
sudo apt-get python-virtualenv
sudo pip install virtualenvwrapper

# get linear algebra libraries
sudo apt-get -y install libatlas-base-dev liblapack-dev

# Numpy and SciPy
pip install numpy scipy

# Horrible install for matplotlib .... The last chord connecting me to Matlab
# Must break chains to matlab.... Must break chains to matlab

apt-cache -y depends python-matplotlib | awk '/Depends:/{print $2}' | xargs dpkg --get-selections

sudo apt-get build-dep python-matplotlib

source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs

mkvirtualenv py27
workon py27

# setup ipython for console work
pip install -e git+https://github.com/ipython/ipython.git#egg=ipython
cd ~/.virtualenvs/py27/src/ipython
python setupegg.py install

# install qt4 tools
sudo apt-get -y install qt4-dev-tools

# install sip
pip install sip
cd ~/.virtualenvs/py27/build/sip
python configure.py
make
sudo make install

#install pyqt
pip install pyqt
cd ~/.virtualenvs/py27/build/pyqt
python configure.py
make

sudo make install

# clean up
cd ~/.virtualenvs/py27/
rm -rf build


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



