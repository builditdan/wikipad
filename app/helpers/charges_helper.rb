
module ChargesHelper


  def display_money(amount)
   Money.us_dollar(amount).format
  end

  def validate_refund(the_amount)

    if the_amount != nil
      if (the_amount.amount_refunded != nil)
        ALREADY_REFUNDED
      elsif @amount.updated_at < (Date.today - 30)
        PAST_30_DAYS
      else
        APPROVED
      end
   else
    NO_RECORD
   end


  end

  def refund_desc(refund_status)

    case refund_status
    when ALREADY_REFUNDED
        "Already refunded payment, please contact support for help!"
    when PAST_30_DAYS
        "You upgraded to premium more than 30 days ago, not eligble for a refund!"
    when NO_RECORD
        "No record of your transaction, contact support for help!"
    when APPROVED
        "Approved"
    else
        "Undefined refund status, contact support for help!"
    end

  end

end
