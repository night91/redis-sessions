# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simple-redis-sessions/version"

Gem::Specification.new do |spec|
  spec.name          = "simple-redis-sessions"
  spec.version       = Simple::Redis::Sessions::VERSION
  spec.authors       = ["Eddy Roberto Morales Perez"]
  spec.email         = ["eddyr.morales@gmail.com"]

  spec.summary       = "Simple gem to handle redis sessions"
  spec.description   = "Simple gem to handle redis sessions in Sinatra and Grape"
  spec.homepage      = "https://github.com/night91/simple-redis-sessions"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "redis", "~> 3.2"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
