class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki, :params

 def update?

    if record.private_changed?
      if user.admin?
        true
      elsif user.premium? && record.user_id == user.id
        true
      else
        false
      end
   else
      true
   end

 end


 end
