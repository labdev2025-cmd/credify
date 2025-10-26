# config/initializers/devise.rb
Devise.setup do |config|
  require "devise/orm/active_record"

  config.mailer_sender = "please-change-me@example.com"
  config.case_insensitive_keys = []
  config.strip_whitespace_keys = []
  config.skip_session_storage = [ :http_auth ]
  config.stretches = Rails.env.test? ? 1 : 12
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
  config.timeout_in = 30.minutes
end
