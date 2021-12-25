require 'faker'

# Admin
User.create(email: 'kindnesspassedon@gmail.com', password: 'password')

# Users 
3.times do 
  User.create(email: Faker::Internet.email , password: 'password' )
end


# Pebbles
Pebble.create(pebble_key: 'P-ABC123', city: 'Columbus', region: 'Ohio', country: 'US')
location = {
  city: Faker::Address.city, 
  region: Faker::Address.state, 
  country:Faker::Address.country_code, 
  postal_code: Faker::Address.postcode
}
Pebble.generate(amount: 3, location: location)

