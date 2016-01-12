include RandomData

5.times do
   user = User.create!(
   name:     RandomData.random_name,
   email:    RandomData.random_email,
   password: RandomData.random_password
   )
 end
 users = User.all

 admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  role: 'admin'
)

standard = User.create!(
   name:     'Standard User',
   email:    'standard@example.com',
   password: 'password',
   role: 'standard'
 )

 premium = User.create!(
   name: 'Premium User',
   email: 'premium@example.com',
   password: 'password',
   role: 'premium'
 )

 puts "Seed finished"
 puts "#{User.count} users created"
