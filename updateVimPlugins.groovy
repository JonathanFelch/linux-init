#!/usr/bin/env groovy 

def cli = new CliBuilder(usage: 'updateVimPlugins [bundlesPath]', header: 'initializes .vim/bundles directories for pathogen-compatible vim plugins' )
cli.h(longOpt: 'help', 'usage details', required: false)

def options = cli.parse(args)
if(options.h ) {  
  cli.usage()
  System.exit(0);
} 

def gitBundles = [ 
  "git://github.com/ervandew/supertab.git",
  "git://github.com/godlygeek/tabular.git",
  "git://github.com/hallison/vim-rdoc.git",
  "git://github.com/msanders/snipmate.vim.git",
  "git://github.com/pangloss/vim-javascript.git",
  "git://github.com/scrooloose/nerdtree.git",
  "git://github.com/timcharper/textile.vim.git",
  "git://github.com/tpope/vim-cucumber.git",
  "git://github.com/tpope/vim-fugitive.git",
  "git://github.com/tpope/vim-git.git",
  "git://github.com/tpope/vim-haml.git",
  "git://github.com/tpope/vim-markdown.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/tpope/vim-vividchalk.git",
  "git://github.com/tsaleh/taskpaper.vim.git",
  "git://github.com/tsaleh/vim-matchit.git",
  "git://github.com/tsaleh/vim-shoulda.git",
  "git://github.com/tsaleh/vim-tcomment.git",
  "git://github.com/tsaleh/vim-tmux.git",
  "git://github.com/vim-scripts/Gist.vim.git",
]

vimOrgScripts = [
  ["IndexedSearch", "7062",  "plugin"],
  ["jquery",        "12107", "syntax"],
]


def env = System.getenv()
def userHome = env['HOME']
def bundlesPath = options.arguments().isEmpty() ? '$userHome/.vim/bundle' : options.arguments()[0]
println "bundlesPath:  $bundlesPath"

def dir = new File(bundlesPath)
println "trashing everything (lookout!)"

dir.deleteDir()
dir.mkdirs()

gitBundles.each { url ->
  def bundleName = url.split('/')[-1].replaceAll(/\.git$/, '')
  def cmd = "git clone ${url} ${bundlesPath}/$bundleName"
  println "unpacking ${url} into ${dir} using cmd -> $cmd"
  cmd.execute()
}

vimOrgScripts.each { tuple ->
  def (name, script_id, script_type) = tuple
  
  def localFilename = "${name}.vim"
  def url = "http://www.vim.org/scripts/download_script.php?src_id=${script_id}"
  def localDir = "${bundlesPath}/${name}/"
  new File(localDir).mkdir();
  def localFile = new File(new File(localDir), localFilename)
  
  println "downloading ${name} from ${url} to ${localFile}"

  def out = new BufferedOutputStream(new FileOutputStream(localFile))
  out << new URL(url).openStream()
  out.flush()
  out.close()
}


