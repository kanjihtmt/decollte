source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'slim-rails'
gem 'bootstrap', '~> 4.3.1'
gem 'font-awesome-sass', '~> 5.0.6'
gem 'jquery-rails'
gem 'devise'
gem 'kaminari'
gem 'bootstrap4-kaminari-views'
gem 'active_decorator'
gem 'enum_help'
gem 'seed-fu'
gem 'acts_as_list'
gem 'pundit'
gem 'rubocop', require: false

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
end

group :test do
  gem 'spring-commands-rspec'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
