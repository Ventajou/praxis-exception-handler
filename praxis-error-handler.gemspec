lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "praxis-exception-handler"
  spec.version       = "1.0"
  spec.authors = ["André Rieussec"]
  spec.summary       = %q{More flexible error handling for Praxis.}
  spec.email = ["andre@ventajou.com"]

  spec.homepage = "https://github.com/ventajou/praxis-error-handler"
  spec.license = "MIT"
  spec.required_ruby_version = ">=2.1"

  spec.require_paths = ["lib"]
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_runtime_dependency 'praxis', [">= 0.18"]
  spec.add_runtime_dependency 'praxis-blueprints', [">= 2.2"]
  spec.add_runtime_dependency 'praxis-mapper', [">= 4.1"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 0"
end
