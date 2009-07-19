# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_barcampalsace6_session',
  :secret      => '290fcab1c51a5441e8c8b94682441f78fe623c936426bf865fefdcff41a9d8acbe703d7d6257a1aa6aa59f3b549021ed1fd88e7be807bac7ddebe5eb623b050a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
