require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Invoicing
  class Application < Rails::Application
    config.time_zone = "Wellington"
    config.active_record.raise_in_transactional_callbacks = true
  end
end

SimpleGoogleAuth.configure do |config|
  config.client_id = Rails.application.secrets.google_id
  config.client_secret = Rails.application.secrets.google_secret
  config.redirect_uri = Rails.application.secrets.google_redirect_url

  config.authenticate = lambda do |data|
    data.email == Rails.application.secrets.authenticated_email
  end
end
