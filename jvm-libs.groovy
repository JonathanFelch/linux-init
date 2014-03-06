

// define STAGING directory.... Must end in /tmp
def STAGING=System.getenv()['GRAPE_STAGING'];
if (!STAGING || !(STAGING =~ /tmp$/)) {
    println "Downloads must specify local repository ending with tmp.  Use -Dgrape.roo=XYZ of specify an Java System value!"
    System.exit(0)
}


// specify LIB dircetory
def LIB=STAGING.replaceAll('/tmp','')

// define our core libraries ... code is data ... data is code

def coreLibraries = [ 
    [org:'org.scala-saddle', artifact:'saddle-core_2.10', version:'1.3.1'],
    [org:'org.scala-saddle', artifact:'saddle-hdf5_2.10', version:'1.3.1'],
    [org:'org.scala-saddle', artifact:'jhdf5_2.10', version:'2.9'],
    [org:'org.scalanlp', artifact:'breeze-core_2.10', version:'0.4'],
    [org:'org.scalanlp', artifact:'breeze-math_2.10', version:'0.4'],
    [org:'org.scalanlp', artifact:'breeze-viz_2.10', version:'0.3'],
    [org:'org.scalanlp', artifact:'breeze-learn_2.10', version:'0.3'],
    [org:'org.scalanlp', artifact:'breeze-graphs_2.10', version:'0.2.3'],
    [org:'org.scalanlp', artifact:'breeze-process_2.10', version:'0.3'],
    [org:'org.scalanlp', artifact:'chalk', version:'1.2.0'],
    [org:'org.scalanlp', artifact:'nak', version:'1.1.3'],
    [org:'org.jfree', artifact:'jfreechart', version:'1.0.15'],
    [org:'org.apache.commons', artifact:'commons-math3', version:'3.2'],
    [org:'org.apache.directory.studio', artifact:'org.apache.commons.logging', version:'1.1.1'],
    [org:'org.apache.directory.studio', artifact:'org.apache.commons.io', version:'2.4'],
    [org:'org.apache.directory.studio', artifact:'org.apache.commons.lang', version:'2.6'],
    [org:'org.apache.directory.studio', artifact:'org.apache.commons.collections', version:'3.2.1'],
    [org:'commons-net', artifact:'commons-net', version:'3.3'],
    [org:'commons-configuration', artifact:'commons-configuration', version:'1.8'],
    [org:'com.googlecode.efficient-java-matrix-lib
    rary', artifact:'ejml', version:'0.23'],
    [org:'joda-time', artifact:'joda-time', version:'2.3'],
    [org:'org.joda', artifact:'joda-convert', version:'1.2'],
    [org:'com.google.guava', artifact:'guava', version:'14.0.1'],
    [org:'org.slf4j', artifact:'slf4j-api', version:'1.7.5'],
    [org:'org.slf4j', artifact:'slf4j-log4j12', version:'1.7.5'],
    [org:'log4j', artifact:'log4j', version:'1.2.17'],
    [org:'it.unimi.dsi', artifact:'fastutil', version:'6.5.4'],
    [org:'it.unimi.dsi', artifact:'dsiutils', version:'2.0.15']

]

/*
 * This should change to support javadocs and source code but the grape to ivy to maven interface is not 
 * downloading the other artifacts to the correct directory
 */
def types = [ 'jar' ]  

// closure to make execution and exception handing a one-liner
def sourceLib = { props -> 
  try { groovy.grape.Grape.grab(props) } catch(Exception e) { println e } 
}


// for each library download each time of artifacts
coreLibraries.each { lib ->
   def tuple = [ transitive: false, group: lib.org, module: lib.artifact, version: lib.version ]
   types.each { tuple['type'] = it; println tuple; sourceLib(tuple) }
}

// linux command to be sent to shell 
def cmd = "find $STAGING -name *.jar -exec mv {} $LIB \\;"
cmd.execute();

// delete tmp directory 
new File(STAGING).deleteDir()
