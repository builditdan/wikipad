include RandomData

5.times do
   user = User.create!(
   name:     RandomData.random_name,
   email:    RandomData.random_email,
   password: RandomData.random_password,
   confirmed_at: Time.now
   )
 end

 users = User.all

 admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'password',
  confirmed_at: Time.now,
  role: 'admin'
)

standard = User.create!(
   name:     'Standard User',
   email:    'standard@example.com',
   password: 'password',
   confirmed_at: Time.now,
   role: 'standard'
 )

 premium = User.create!(
   name: 'Premium User',
   email: 'premium@example.com',
   password: 'password',
   confirmed_at: Time.now,
   role: 'premium'
 )

#let(:my_wiki) {Wiki.create!(title: "My first wiki", body: " This is some cool text to add to my wiki", private: false, user_id: my_user.id)}


5.times do
   wiki = Wiki.create!(
   title:   RandomData.random_sentence,
   body:    RandomData.random_paragraph,
   user_id: 1
   )
end

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
