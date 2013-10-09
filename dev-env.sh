#!/bin/bash

#  development environment script three purposes:
#     1.) initialize major components (languages) to defaults if not set
#     2.) add standard dependancies for linux/C, jvm, and python runtimes 
#     3.) 'prep' environment and dependancies for 'workon' project scripts
#


# setup regex for blanks
BLANK_REGEX="^( )+$"

# set up environment defaults for major software / language components
if [ -z ${JAVA_HOME} ] ; then
  export JAVA_HOME=/usr/lib/jvm/java-7-oracle
fi

if [ -z ${GROOVY_HOME} ]; then
  export GROOVY_HOME=/opt/groovy/default
fi

if [ -z ${SCALA_HOME} ]; then
  export SCALA_HOME=/opt/scala/default
fi

if [ -z ${JDK_HOME} ]; then
  export JDK_HOME=$JAVA_HOME
fi

# Mongo has been removed from the big data stack for now
# export MONGODB_HOME=/opt/mongodb/default

# add zmq
if [ -z ${ZEROMQ_HOME} ]; then
  export ZEROMQ_HOME=/opt/zeromq/default
fi

# abd SBT build tool
if [ -z ${SBT_HOME} ]; then
  export SBT_HOME=/opt/sbt
fi

# setup user library and staging directories
mkdir -p ~/lib/jvm/tmp
mkdir -p ~/lib/linux
mkdir -p ~/lib/python

# indicate user JVM staging directory
export GRAPE_STAGING=~/lib/jvm/tmp

# expand path to include default libraries
export PATH=$JDK_HOME/bin:$SCALA_HOME/bin:$GROOVY_HOME/bin:$SBT_HOME/bin:$ZEROMQ_HOME/bin:$MONGODB/bin:$PATH

# initialize JVM user-library repo and set classpath not set
if [ -z ${JVM_LIB} ]; then
  export JVM_LIBS=~/lib/jvm
fi


if [ -z ${CLASSPATH} ]; then
  export CLASSPATH=$(find ${JVM_LIBS} -name '*.jar' | xargs echo | tr ' ' ':')
fi

# add user-level linux dynamic libraries
if [ -z ${LINUX_LIB_PATH} ]; then
  export LINUX_LIB_PATH=~/lib/linux
fi

# save the original LD_LIBRARY_PATH so the development environment can be reset
OS_LIBRARY_PATH=$LD_LIBRARY_PATH

# augument LD_LIBRARY_PATH with user-level libraries
LINUX_LIBS=$(find ${LINUX_LIB_PATH} -name '*.so' | xargs echo | tr ' ' ':')

if ! [ -z ${LINUX_LIBS} ] && ! [[ ${LINUX_LIBS} =~ $BLANK_REGEX ]]; then 
  if [ ${LD_LIBRARY_PATH} ]; then
     export LD_LIBRARY_PATH=$LINUX_LIBS:$LD_LIBRARY_PATH
  else 
     export LD_LIBRARY_PATH=$LINUX_LIBS
  fi
fi

# add user-level python libs
if [ -z ${PYTHON_LIBS} ]; then
  export PYTHON_LIBS=~/lib/python
fi
export PYTHONPATH=$PYTHONPATH:$PYTHON_LIBS
