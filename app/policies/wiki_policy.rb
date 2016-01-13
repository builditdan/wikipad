class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki, :params

 def update?

    if user == nil
    	 false
    elsif record.private_changed? && (record.user_id != user.id)
    	false
    else
      true
    end

 end


 end
