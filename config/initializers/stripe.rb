# Configure Stripe
Stripe.api_key = Credentials.dig(:stripe, :secret_key)
StripeEvent.signing_secret = Credentials.dig(:stripe, :signing_secret)

StripeEvent.configure do |config|
  config.subscribe 'checkout.session.completed' do |event|
    PaymentReceived.call(event)
  end
end