source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: [:development,:test]
gem 'mysql2', group: :production
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'devise', '~> 3.2.0'
gem 'devise-token_authenticatable'
gem 'omniauth'
gem 'rails_admin'
gem 'haml-rails'
gem 'paperclip'

group :production do
  gem 'aws-sdk'
end

group :development,:test do
  gem 'html2haml'
  gem 'erb2haml'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :test, :development do
  gem "pry-rails"
  gem "pry-doc"
  gem "pry-stack_explorer"
  gem "pry-byebug"
  gem "hirb"
  gem "hirb-unicode"
  gem "tapp"
  gem "awesome_print"

  gem "better_errors"
  gem "binding_of_caller"
  gem "quiet_assets"
  gem "annotate", github: "ctran/annotate_models"
  gem "timecop"
  gem "colorize_unpermitted_parameters"
  gem "rack-mini-profiler"
  gem "xray-rails"

#  gem "rspec", "~> 3.0.0.beta"
#  gem "rspec-rails", "~> 3.0.0.beta"
  gem "guard-rspec", require: false
  gem "spring-commands-rspec"
#  gem "factory_girl_rails"
#  gem "database_rewinder"
  gem "faker"

#  gem 'spring-commands-rspec'
#  gem 'rspec-rails'
#  gem 'guard-rspec'
  gem 'rb-fsevent' if `uname` =~ /Darwin/

end
