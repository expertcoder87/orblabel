Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: '0.0.0.0', port: 3000 }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  #mail setting
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true


  config.action_mailer.default_url_options = { :host => 'localhost:3000' } 

  # config.action_mailer.delivery_method = :mailgun
  # config.action_mailer.mailgun_settings = {
  #   :api_key  => "key-318a39fe998af403507a4e0e7fed130a",
  #   :api_host => "email.mg.mydomail.com"
  # }

  # config.action_mailer.smtp_settings = {
  #     enable_starttls_auto: true,
  #     address:              'smtp.gmail.com',
  #     port:                 587,
  #     domain:               'gmail.com',
  #     user_name:            'mylarayuvasoft146@gmail.com',
  #     password:             'yuvasoft146',
  #     authentication:       :login
  #   }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :authentication => :plain,
      :address => "smtp.mailgun.org",
      :port => 587,
      :domain => "sandboxf3bd434eec294320953eb0b55337ea72.mailgun.org",
      :user_name => "postmaster@sandboxf3bd434eec294320953eb0b55337ea72.mailgun.org",
      :password => "e7f6837e0b45a39557370eaa7a9623ba"
  }

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
