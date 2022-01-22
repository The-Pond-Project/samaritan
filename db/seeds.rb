require 'faker'

# Admin
User.create(email: 'kindnesspassedon@gmail.com', password: 'password', role: :super_admin)

# Users 
3.times do 
  User.create(email: Faker::Internet.email , password: 'password' )
end

# Organizations
kpo = Organization.create(name: 'Kindness Passed On', description: 'The official organization for ThePondProject')

# Releases
genesis = Release.create(name: 'Genesis', description: 'The beginning', organization: kpo)
Release.create(name: 'Test Release', description: 'Test', organization: kpo)

# Ponds
Pond.create(key: 'P-ABC123', city: 'Columbus', region: 'Ohio', country: 'US', release: genesis)

# Ripples
3.times do 
  Ripple.create(city:Faker::Address.city,  country: Faker::Address.country_code, user: User.first, pond: Pond.first )
end

# Tags 
Tag.create(name: '#kindnesspassedon', description:'An official tag from The Pond Project team', approved: true, organization: kpo, ripples: [Ripple.first])
Tag.create(name: '#passiton', description:'An official tag from The Pond Project team', approved: true, organization: kpo )
Tag.create(name: '#rippleitout', description:'An official tag from The Pond Project team', approved: true, organization: kpo )
Tag.create(name: '#justbecause', description:'An official tag from The Pond Project team', approved: true, organization: kpo )
Tag.create(name: '#growthepond', description:'An official tag from The Pond Project team', approved: true, organization: kpo )
Tag.create(name: '#ohio', description:'OH! IO! A tag to represent Ohio', approved: true)

# Message Subscriptions
MessageSubscription.create(ripple_uuid: Ripple.first.uuid, phone_number: '+16148097539')

# Stories
Story.create(title: 'A story of kindness', body: 'This is a great story.')