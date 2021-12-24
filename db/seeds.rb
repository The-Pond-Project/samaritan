require 'faker'

# Admin
User.create(email: 'kindnesspassedon@gmail.com', password: 'password')

3.times do 
  User.create(email: Faker::Internet.email , password: 'password' )
end
