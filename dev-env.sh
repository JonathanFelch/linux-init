export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export GROOVY_HOME=/opt/groovy/default
export SCALA_HOME=/opt/scala/default

export JDK_HOME=$JAVA_HOME
export MONGODB_HOME=/opt/mongodb/default

export ZEROMQ_HOME=/opt/zeromq/default
export SBT_HOME=/opt/sbt

mkdir -p ~/lib/jvm/tmp
mkdir -p ~/lib/linux
mkdir -p ~/lib/python

export GRAPE_STAGING=~/lib/jvm/tmp

export PATH=$JDK_HOME/bin:$SCALA_HOME/bin:$GROOVY_HOME/bin:$SBT_HOME/bin:$ZEROMQ_HOME/bin:$MONGODB/bin:$PATH
