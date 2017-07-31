# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.1'
gem 'activerecord-postgis-adapter'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'apipie-rails'
gem 'ar-uuid' # http://nandovieira.com/using-uuid-with-postgresql-and-activerecord
gem 'carrierwave', '~> 1.0' # image upload
gem 'coffee-rails', '~> 4.2'
gem 'fog-aws' # S3
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jwt'
gem 'koala'
gem 'mini_magick'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.2'
gem 'rails_admin', '~> 1.2'
gem 'rest-client'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  # Shim to load environment variables from .env into ENV in development.
  gem 'byebug', platform: :mri
  gem 'dotenv-rails' # https://github.com/bkeepers/dotenv
end
group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'devise'
gem 'high_voltage'
gem 'pg'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
group :development do
  gem 'better_errors'
  gem 'rails_layout'
end
