class AmountPolicy < ApplicationPolicy
  attr_reader :user # :params

   def new?
      byebug
      if user == nil
      	return false
      elsif user.standard?
      	return true
      else
        return false
      end
   end

   def destroy?

     if !user_logged_in?
       false
     elsif user.premium?
       true
     else
       false
     end

   end


 end
