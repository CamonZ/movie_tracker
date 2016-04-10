source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta3', '< 5.1'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
gem 'active_model_serializers'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
gem 'resque'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'omdbapi'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
end

group :test do
  gem 'json-schema'
  gem 'resque_spec'
  gem 'shoulda-matchers'
  gem 'rspec-rails', '3.5.0.beta1'
  gem 'webmock'
  gem 'vcr'
  gem 'response_code_matchers'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
