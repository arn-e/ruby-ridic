# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ridic/version'

Gem::Specification.new do |gem|
  gem.name          = "ridic"
  gem.version       = RiDic::VERSION
  gem.authors       = ["Arne Fostvedt"]
  gem.email         = ["fostvedt.arne@gmail.com"]
  gem.description   = %q{Ruby gem wrapper for the Regressive Imagery Dictionary}
  gem.summary       = %q{Exposes methods to access and search RID}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
