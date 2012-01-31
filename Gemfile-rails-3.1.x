source "http://rubygems.org"

gemspec

gem "kaminari"
gem "rails", ">= 3.1"
gem "sqlite3"
gem "jquery-rails"

group :development do
  gem "ruby-debug19" if RUBY_VERSION == '1.9.2'
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
  gem "rspec-rails"
end
# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'
