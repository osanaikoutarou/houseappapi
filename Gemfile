# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
ruby '2.4.1'
gem 'active_model_serializers'
gem 'activerecord-postgis-adapter'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'ar-uuid' # http://nandovieira.com/using-uuid-with-postgresql-and-activerecord
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'carrierwave', '~> 1.0' # image upload
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'dotenv-rails'
gem 'fog-aws' # S3
gem 'high_voltage'
gem 'i18n_generators'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jwt'
gem 'kaminari'
gem 'koala'
gem 'lograge'
gem 'logstash-event'
gem 'logstash-logger'
gem 'mini_magick'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails_admin', '~> 1.2'
gem 'rails', '~> 5.0.2'
gem 'rest-client'
gem 'sass-rails', '~> 5.0'
gem 'swagger_ui_engine'
gem 'swagger-blocks'
gem 'swagger-docs'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  # Shim to load environment variables from .env into ENV in development.
  gem 'byebug', platform: :mri
end
group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
group :development do
  gem 'better_errors'
  gem 'rails_layout'
end
