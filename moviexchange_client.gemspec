require_relative 'lib/moviexchange_client/version'

Gem::Specification.new do |spec|
  spec.name          = "moviexchange_client"
  spec.version       = MoviexchangeClient::VERSION
  spec.authors       = ["Kips"]
  spec.email         = ["kips@cinematik.app"]

  spec.summary       = %q{A wrapper for the moviexchange API}
  spec.description   = %q{A wrapper for the moviexchange API}
  spec.homepage      = "https://github.com/ourscreen/moviexchange_client"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files = [".rspec", "Gemfile", "Guardfile", "LICENSE.txt", "README.md", "RELEASING.md", "Rakefile", "moviexchange_client.gemspec"]
  spec.files += Dir["lib/**/*.rb"]
  spec.files += Dir["lib/**/*.rake"]
  spec.files += Dir["spec/**/*.rb"]

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Add runtime dependencies here
  spec.add_runtime_dependency "activesupport", ">=3.0.0"
  spec.add_runtime_dependency "httparty", ">=0.10.0"

  # Add development-only dependencies here
  spec.add_development_dependency("rake", "~> 11.0")
  spec.add_development_dependency("rspec", "~> 2.0")
  spec.add_development_dependency("rr")
  spec.add_development_dependency("pry")
  spec.add_development_dependency("webmock")
  spec.add_development_dependency("vcr")
  # spec.add_development_dependency("rdoc")
  spec.add_development_dependency("bundler")
  # spec.add_development_dependency("simplecov")
  # spec.add_development_dependency("awesome_print")
  # spec.add_development_dependency("timecop")
  spec.add_development_dependency("guard-rspec")
end
