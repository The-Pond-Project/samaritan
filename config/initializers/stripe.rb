# Configure Stripe
Stripe.api_key = EnvSecret.get('STRIPE_SECRET_KEY')
StripeEvent.signing_secret = EnvSecret.get('STRIPE_SIGNING_SECRET')

StripeEvent.configure do |config|
  config.subscribe 'checkout.session.completed' do |event|
    PaymentReceived.call(event)
  end
end