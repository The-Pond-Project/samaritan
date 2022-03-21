Twilio.configure do |config|
  config.account_sid = Credentials.dig(:twilio, :twilio_account_sid)
  config.auth_token = Credentials.dig(:twilio, :auth_token)
end