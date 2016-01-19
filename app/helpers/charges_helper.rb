
module ChargesHelper


  def display_money(amount)
    Money.us_dollar(amount).format
  end

  def count_private_wikis_for_user(user)

    Wiki.where(private: true, user_id: user.id).count

  end


end
