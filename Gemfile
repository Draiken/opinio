source "http://rubygems.org"

gemspec

gem "kaminari"
gem "rails", "4.0.0"
gem "sqlite3"
gem "jquery-rails"
gem "protected_attributes"

group :development do
  platforms :mri_19 do
    gem "debugger"
  end
  gem 'guard-rspec'
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent'
    gem 'growl'
  end
end

group :test do
  gem "cucumber"
  gem "cucumber-rails"
  gem "capybara"
  gem "launchy"
  gem "database_cleaner"
  gem "rspec-rails", :git => "https://github.com/rspec/rspec-rails.git", :tag => "v2.12.2"
end
# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'
