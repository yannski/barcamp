source 'https://rubygems.org'


ruby '2.0.0'
gem 'rails', '~> 3.2.13'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'rails-i18n'
gem 'dynamic_form'
gem 'jquery-rails'
gem 'haml-rails'
gem 'paperclip'
gem 'mongoid'
gem 'fog'
gem 'mongoid-paperclip', :require => 'mongoid_paperclip'
gem 'gravatar_image_tag'
gem 'rack-google-analytics', :require => 'rack/google-analytics'


gem 'pry-rails', group: [:development]
gem 'pry-nav', group: [:development]
gem 'dotenv-rails', :groups => [:development, :test]

group :production do
  gem 'puma'
end
