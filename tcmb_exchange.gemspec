
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tcmb_exchange/version"

Gem::Specification.new do |spec|
  spec.name          = "tcmb_exchange"
  spec.version       = TcmbExchange::VERSION
  spec.authors       = ["hamityay"]
  spec.email         = ["hamityay@hotmail.com"]
  spec.add_runtime_dependency "nokogiri",
    [">= 1.8.0"]

  spec.summary       = %q{Anlık olarak tcmb.gov.tr üzerinden döviz kurlarını almanızı sağlar. TCMB tcmb_currency}
  spec.description   = %q{http://www.tcmb.gov.tr/kurlar/today.xml adreasindeki verileri dinamik olarak almanızı sağlar.TCMB tcmb_currency}
  spec.homepage      = "https://rubygems.org/gems/tcmb_exchange"
  spec.metadata      = { "source_code_uri" => "https://github.com/hamityay/tcmb_exchange" }
  spec.license       = "GPL-3.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
