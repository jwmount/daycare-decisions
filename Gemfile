source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '>=4.1'
gem 'rake', '>=10.3.2'


# sprockets Environment error, it's ALWAYS sprockets
# http://stackoverflow.com/questions/22426698/undefined-method-environment-for-nilnilclass-when-importing-bootstrap-into-ra
gem 'coffee-rails'
gem "sass-rails", "~> 4.0.2"
gem "twitter-bootstrap-rails"
gem "bootstrap-sass"
gem "therubyracer"
gem "less-rails"   # added to move to frontend

gem 'haml-rails'
gem 'geocoder'

gem 'carrierwave'
gem 'devise'
gem 'cancan'
# Allows the use of foreign keys used to protect data integrity (per Xavier Shay)
gem 'foreigner'
gem 'i18n'
gem 'taps'  #needed by Heroku

gem 'uglifier', '>= 1.0.3'
gem "country_select"

group :development do
  gem 'mysql2'
  gem 'better_errors' 
  gem 'binding_of_caller'
end

group :production do
  # Support for Rails 4 by & for Heroku, removed for Ninefold
  # gem 'rails_12factor'
  # needed for asset pipeline cache by Heroku, all 4.0.x releases, is in 4.1.x
  gem 'sprockets_better_errors'
  gem 'pg'
  gem 'ninefold'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :assets do
  gem 'jquery-ui-rails', '~> 4.2.1'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Rails 4 support, see https://github.com/gregbell/active_admin/pull/2326
# http://stackoverflow.com/questions/20648814/rails-4-1-0-beta1-upgrade-fails
gem 'formtastic', github: 'justinfrench/formtastic'
gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'rails-4.1'
gem 'polyamorous', github: 'activerecord-hackery/polyamorous'
gem 'activeadmin', github: 'gregbell/active_admin'