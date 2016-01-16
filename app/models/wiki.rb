class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true
  scope :show_by_role, -> (user) {user && (user.admin? || user.premium?) ? all : where(private: false)}
  scope :show_private, -> {where(private: true)}
  scope :show_public, ->  {where(private: false)}



end
