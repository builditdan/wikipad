class Amount < ActiveRecord::Base
belongs_to :user

  def self.default
    10_00
  end



end
