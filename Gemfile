# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'
gem 'rails', '~> 6.0.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2.3'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use JSON web tokens for request-auth
gem 'jwt', '~> 2.2.1'

# Use Puma as the app server
gem 'puma', '~> 4.3.3'

# Reduce boot times through caching
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for cross-origin AJAX
gem 'rack-cors', '~> 1.1.1'
# Use Rack::Attack for throttling by IP
gem 'rack-attack', '~> 6.2.2'

# Build JSON APIs
gem 'jbuilder', '~> 2.10.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'byebug', platforms: :mri
  gem 'rubocop', '~> 0.81.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
