
module ChargesHelper


  def display_money(amount)
   Money.us_dollar(amount).format
  end


end
