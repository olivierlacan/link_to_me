require_relative 'lib/link_to_me/version'

Gem::Specification.new do |spec|
  spec.name          = "link_to_me"
  spec.version       = LinkToMe::VERSION
  spec.authors       = ["Olivier Lacan"]
  spec.email         = ["hi@olivierlacan.com"]

  spec.summary       = %q{Extend link_to to autolink Active Record model instances}
  spec.description   = %q{Give link_to the ability to point to the show page of an Active Record model instance resource.}
  spec.homepage      = "https://github.com/olivierlacan/link_to_me"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/olivierlacan/link_to_me"
  spec.metadata["changelog_uri"] = "https://github.com/olivierlacan/link_to_me/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
