module RandomData

# Follow https://github.com/stympy/faker for more options
# Only use FAKER in DEV as could pose a security risk

 def random_name
     first_name = Faker::Name.first_name
     last_name = Faker::Name.last_name.capitalize
     "#{first_name} #{last_name}"
 end

 def random_email
   #{}"#{random_word}@#{random_word}.#{random_word}"
   Faker::Internet.email
 end

 def random_password
   Faker::Internet.password
 end

  def random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end

    sentences.join(" ")
  end

  def random_sentence
    #strings = []
    #rand(3..8).times do
    #  strings << random_word
    #end

    #sentence = strings.join(" ")
    #sentence.capitalize << "."
    Faker::Hacker.say_something_smart.capitalize

  end

  def random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end

end
