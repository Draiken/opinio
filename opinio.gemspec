# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "opinio"
  s.summary = "A rails 3 engine for comments."
  s.description = "Opinio is an engine used to add comments functionallity to rails 3 applications."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.2"
end
