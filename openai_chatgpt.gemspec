# frozen_string_literal: true

require_relative "lib/openai_chatgpt/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name = "openai_chatgpt"
  spec.version = OpenaiChatgpt::VERSION
  spec.authors = ["Sulman Baig"]
  spec.email = ["sulman@hey.com"]

  spec.summary = "OpenAI ChatGPT API is a light-weight Ruby wrapper for the Rubyists.\
  All models of gpt-4 and gpt-3.5 supported."
  spec.description = "OpenAI ChatGPT API is a light-weight Ruby wrapper for the Rubyists.\
  [`gpt-4`, `gpt-4-0314`, `gpt-4-32k`, `gpt-4-32k-0314`, `gpt-3.5-turbo`,\
  `gpt-3.5-turbo-0301`]. You can use this gem to generate text using OpenAI's ChatGPT\
  chat responses API."
  spec.homepage = "https://github.com/sulmanweb/openai_chatgpt"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sulmanweb/openai_chatgpt"
  spec.metadata["changelog_uri"] = "https://github.com/sulmanweb/openai_chatgpt/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = %w[README.md]

  spec.add_dependency("faraday", "~> 2.5")
  spec.add_development_dependency("rubocop", "~> 1.35")
  spec.metadata["rubygems_mfa_required"] = "true"
end
# rubocop:enable Metrics/BlockLength
