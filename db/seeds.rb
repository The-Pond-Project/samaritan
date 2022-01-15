require 'faker'

# Admin
User.create(email: 'kindnesspassedon@gmail.com', password: 'password', role: :super_admin)

# Users 
3.times do 
  User.create(email: Faker::Internet.email , password: 'password' )
end


# Ponds
Pond.create(key: 'P-ABC123', city: 'Columbus', region: 'Ohio', country: 'US')
location = {
  city: Faker::Address.city, 
  region: Faker::Address.state, 
  country:Faker::Address.country_code, 
  postal_code: Faker::Address.postcode
}
Pond.generate(amount: 3, location: location)

# Ripples
3.times do 
  Ripple.create(city:Faker::Address.city,  country: Faker::Address.country_code, user: User.first, pond: Pond.first )
end

# Tags 
Tag.create(name: '#kindnesspassedon', description:'An official tag from The Pond Project team', approved: true, organization: 'The Pond Project', ripples: [Ripple.first])
Tag.create(name: '#passiton', description:'An official tag from The Pond Project team', approved: true, organization: 'The Pond Project')
Tag.create(name: '#rippleitout', description:'An official tag from The Pond Project team', approved: true, organization: 'The Pond Project')
Tag.create(name: '#justbecause', description:'An official tag from The Pond Project team', approved: true, organization: 'The Pond Project')
Tag.create(name: '#growthepond', description:'An official tag from The Pond Project team', approved: true, organization: 'The Pond Project')
Tag.create(name: '#ohio', description:'OH! IO! A tag to represent Ohio', approved: true)

# Message Subscriptions
MessageSubscription.create(ripple_uuid: Ripple.first.uuid, phone_number: '+16148097539')


# Organizations
Organization.create(name: 'Kindness Passed On', description: 'The official organization for ThePondProject')

# Stories
Story.create(title: 'A story of kindness', body: 'This is a great story.')