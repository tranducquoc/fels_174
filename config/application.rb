require File.expand_path('../boot', __FILE__)

require "rails/all"
require "csv"

Bundler.require(*Rails.groups)

module BaseApp
  class Application < Rails::Application

    config.active_record.raise_in_transactional_callbacks = true
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    I18n.available_locales = [:en]
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
