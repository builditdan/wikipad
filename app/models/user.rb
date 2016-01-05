class User < ActiveRecord::Base


  before_save {
    self.email = email.downcase
    #convert name to a string
    temp = name.to_s
    #split name into words and then capitalize but only if a space exists
    self.name = temp.split(' ').map(&:capitalize).join(' ') if temp.match(/.\s./)
  }

  # if self role is not defined then default to a member role
  before_save {self.role ||= :standard }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 100 },
             format: { with: EMAIL_REGEX }

  # not sure where this is defined
  has_secure_password

  enum role: [:standard, :admin, :premium]

  def avatar_url(size)
      gravatar_id = Digest::MD5::hexdigest(self.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end


end
