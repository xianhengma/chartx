# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chartx/version'

Gem::Specification.new do |spec|
  spec.name          = "chartx"
  spec.version       = Chartx::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Xianheng Ma"]
  spec.email         = ["xianheng.ma@gmail.com"]
  spec.description   = "Generate beautiful charts in rails"
  spec.summary       = "Generate beautiful charts in rails"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "railties", ">= 3.2.0", "< 5.0"
  
  `git submodule --quiet foreach pwd`.split($\).each do |sub_path|
    Dir.chdir(sub_path) do
 
      sub_files = `git ls-files`.split($\)
      sub_files_fullpaths = sub_files.map do |filename|
        "#{sub_path}/#{filename}"
      end

      sub_files_paths = sub_files_fullpaths.map do |filename|
        filename.gsub "#{File.dirname(__FILE__)}/", ""
      end

      spec.files += sub_files_paths
    end
  end
end
