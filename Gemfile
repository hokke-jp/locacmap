source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'active_storage_validations', '0.8.2'
gem 'aws-sdk-s3', '1.48', require: false
gem 'bcrypt', '3.1.13'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails'
gem 'faker', '2.1.2'
gem 'image_processing', '1.9.3'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'mini_magick', '4.9.5'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.0'
gem 'rails', '6.1.0'
gem 'rails-i18n'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0.2'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
end

group :production, :staging do
  gem 'unicorn', '5.4.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'tailwindcss-rails', '~> 0.3.3'
