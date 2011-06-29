require 'fileutils'
require 'gemit/string_ext'

class Gemit
  attr_reader :name

  def initialize(name)
    @name = name    
    @verbose = true
  end

  def generate
    raise "Name cannot contain white spaces!" if @name =~ /\s/ 
    raise "Folder already exists #{@name}" if File.exists? @name

    FileUtils.mkdir_p(File.join(@name, "bin"), :verbose => @verbose)
    FileUtils.mkdir_p(File.join(@name, "lib"), :verbose => @verbose)
    FileUtils.mkdir_p(File.join(@name, "lib", @name), :verbose => @verbose)

    create_file(gemspec_file, gemspec)
    create_file(readme_file, readme)
    create_file(version_file, version)
    create_file(lib_file, lib)
    create_file(executable_file, executable)
  end

  private

  def create_file(name, content)
    file_name = File.join(@name, name)
    File.open(file_name, 'w') {|f| f.write(content) }
    puts "created #{file_name}" if @verbose
  end

  def gemspec_file
    "#{@name}.gemspec"
  end
  
  def readme_file
    "README.md"
  end

  def version_file
    File.join("lib", @name, "version.rb").to_s
  end

  def lib_file
    File.join("lib", "#{@name}.rb")
  end

  def executable_file
    File.join("bin", "#{@name}")
  end

  def gemspec
    <<GEMSPEC
# encoding: utf-8

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require "#{@name}/version"

Gem::Specification.new do |s|
  s.name        = "#{@name}"
  s.version     = #{@name.classify}::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = `git config --get user.name`
  s.email       = `git config --get user.email`
  s.homepage    = %q{}

  s.summary     = %q{}
  s.description = %q{}

  s.rubyforge_project = "#{@name}"

  s.files         = `git ls-files`.split("\\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\\n")
  s.executables   = `git ls-files -- bin/*`.split("\\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 1.8.7'
end
GEMSPEC
  end

  def readme
    <<README
#{@name.classify}
#{@name.classify.length.times.collect{'='}}

Intallation
-----------
* gem install #{@name}
README
  end
  def version
    <<VERSION
class #{@name.classify}
  VERSION = "0.0.1"
end
VERSION
  end
  def lib
    <<LIB
class #{@name.classify}
#Fill in the gaps :P
end
LIB
  end
  def executable
    <<EXECUTABLE
#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require '#{@name}'

EXECUTABLE
  end
end
