# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "redis_sessions/version"

Gem::Specification.new do |spec|
  spec.name          = "redis-sessions"
  spec.version       = Grape::RedisSessions::VERSION
  spec.authors       = ["Eddy Roberto Morales Perez"]
  spec.email         = ["eddyr.morales@gmail.com"]

  spec.summary       = "Ssession based on access token for Grape using a Redis server as datastore"
  spec.description   = "Simple gem to provide session based on access token for Grape using a Redis server as datastore"
  spec.homepage      = "https://github.com/night91/redis-sessions"
  spec.license       = "MIT"
  
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "redis", "~> 3.2"
  spec.add_runtime_dependency "grape", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
