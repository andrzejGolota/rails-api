source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'

gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :test do
  gem 'database_cleaner'
  gem 'launchy'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'rails-erd'
  gem 'sqlite3'
  gem 'spring'
end

#omniauth strategies
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-linkedin-oauth2'
gem 'omniauth-paypal-openid'
gem 'omniauth-vkontakte'
gem 'omniauth'

gem 'devise'
gem 'paypal-sdk-rest' #will try to implement payments
gem 'cancancan', '~> 2.0'
gem 'pg'
gem 'swagger-docs'
gem 'delayed_job_active_record' #sending emails
gem 'haml'
gem 'aasm' #state machine would be helpful
gem 'roo'
gem 'axlsx'
gem 'prawn'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
