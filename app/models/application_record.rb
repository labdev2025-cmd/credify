class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(auth_object = nil)
    column_names - %w[
      encrypted_password
      password_salt
      password_hash
      password_digest
      password_reset_token
      reset_password_token
      reset_password_sent_at
      remember_created_at
      confirmation_token
      confirmed_at
      confirmation_sent_at
      unconfirmed_email
      unlock_token
      locked_at
      failed_attempts
      owner
      api_key
      access_token
      auth_token
      secret_token
      session_token
      jwt_token
      private_key
      public_key
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map(&:name).map(&:to_s)
  end

end
