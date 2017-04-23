source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '3.2.11' #'4.2.3' Need to downgrade the rails version as there is a security vulnerability
                        #https://blog.heroku.com/rails_security_vulnerability
# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: :development # Added development group.
gem 'pg', group: :production # Added postgres and made it production only.
gem 'rails_12factor'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 3.2.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 3.2.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.3.0', group: :doc

gem 'therubyracer', platforms: :ruby
gem 'capybara', '~> 2.4.4'
gem 'poltergeist', '~> 1.6.0'
gem 'phantomjs', '~> 1.9.8.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  #gem 'web-console', '~> 1.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


gem 'httparty'

gem 'figaro'

gem 'mysql2', '~>0.3.13'

gem 'pry'

#Chartkick to display awesome charts
gem 'chartkick', '~> 1.2.4'

#Terminal commands to make life easier when dealing with data for charts
#These require either MySQL or Postgres and will NOT work with SQLite
gem 'groupdate', '~> 2.1.1'
gem 'active_median', '~> 0.1.0'
