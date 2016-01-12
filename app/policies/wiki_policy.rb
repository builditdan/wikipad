class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki, :params

 def update?

    if user == nil
    	return false
    elsif record.private_changed? && (record.user_id != user.id)
    	return false
    else
        return true
    end        
 #      current_user
 #       (current_useruser.admin? or user.standard? or user.premium?      
 end


 end
