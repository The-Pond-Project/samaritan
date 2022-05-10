require 'faker'

if Rails.env.development?
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

  # Bills
  Bill.create(
    name: 'NGROK HTTP Development Tunneling',
    description: 'Ngrok is a tool used for development of the Mission For Kindness Platform.',
    recurrence: 0,
    expense_type: 0,
    amount: 60.00,
    paid: false,
    due_at: Time.current + 365.days
  )
elsif Rails.env.production?
  # Production Seeds
  User.find_or_create(email: 'kindnesspassedon@gmail.com', password: Rails.application.credentials.dig(:pond, :sudo_password), role: :super_admin)
  User.find_or_create(email: 'micahbowie20@gmail.com', password: Rails.application.credentials.dig(:pond, :sudo_password), role: :admin)

  # Organizations
  mfk = Organization.find_or_create(name: 'Mission For Kindness', description: 'Mission For Kindness is the organization that started The Pond Project. This is the official orgnization where you can find all free releases and other general information/stats.')

  # Tags 
  Tag.find_or_create(name: '#kindnesspassedon', description:'An official tag from The Pond Project team', approved: true, organization: mfk)
  Tag.find_or_create(name: '#passiton', description:'An official tag from The Pond Project team', approved: true, organization: mfk )
  Tag.find_or_create(name: '#rippleitout', description:'An official tag from The Pond Project team', approved: true, organization: mfk )
  Tag.find_or_create(name: '#justbecause', description:'An official tag from The Pond Project team', approved: true, organization: mfk )
  Tag.find_or_create(name: '#growthepond', description:'An official tag from The Pond Project team', approved: true, organization: mfk )
  Tag.find_or_create(name: '#ohio', description:'OH! IO! A tag to represent Ohio', approved: true, organization: mfk)
  Tag.find_or_create(name: '#altruist', description:'A tag for people that believe in people', approved: true, organization: mfk)
  Tag.find_or_create(name: '#genesispond', description:'A tag for ponds from the original release', approved: true, organization: mfk)
  Tag.find_or_create(name: '#missionforkindness', description:'An official tag from The Pond Project team', approved: true, organization: mfk)
end 

