sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update

sudo apt-get -y install aptitude curl 
sudo apt-get -y install vim-gnome


sudo apt-get purge openjdk-\* 

sudo apt-get -y install oracle-java6-installer
sudo apt-get -y install oracle-java7-installer

sudo curl -s get.gvmtool.net | bash

source ~/.gvm/bin/gvm-init.sh


#wget -c 'http://sourceforge.net/projects/boost/files/boost/1.50.0/boost_1_50_0.tar.bz2/download'
#tar xf download
#cd boost_1_50_0
#./bootstrap.sh
#./b2 install

sudo apt-get -y install python-dev python-pip

sudo apt-get python-virtualenv
sudo pip install virtualenvwrapper

sudo apt-get -y install libatlas-base-dev liblapack-dev
pip install numpy scipy

apt-cache -y depends python-matplotlib | awk '/Depends:/{print $2}' | xargs dpkg --get-selections

sudo apt-get build-dep python-matplotlib

source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs

mkvirtualenv py27
workon py27

pip install -e git+https://github.com/ipython/ipython.git#egg=ipython
cd ~/.virtualenvs/py27/src/ipython
python setupegg.py install

sudo apt-get -y install qt4-dev-tools

pip install sip
cd ~/.virtualenvs/py27/build/sip
python configure.py
make
sudo make install

pip install pyqt
cd ~/.virtualenvs/py27/build/pyqt
python configure.py
make

sudo make install

# clean up
cd ~/.virtualenvs/py27/
rm -rf build

sudo apt-get -y install libzmq-dev
pip install tornado pygments pyzmq

