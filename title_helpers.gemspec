# -*- encoding: utf-8 -*-
require File.expand_path('../lib/title_helpers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Henrik Nyh"]
  gem.email         = ["henrik@nyh.se"]
  gem.summary       = %q{Rails title helpers.}
  gem.homepage      = "https://github.com/henrik/title_helpers"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "title_helpers"
  gem.require_paths = ["lib"]
  gem.version       = TitleHelpers::VERSION
end
