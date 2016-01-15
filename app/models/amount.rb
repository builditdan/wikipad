class Amount < ActiveRecord::Base
belongs_to :user

  def self.default
    10_00
  end

  def valid_refund?

    if (!self.blank? && !self.amount_refunded.blank?)
      false # ALREADY_REFUNDED
    elsif !self.blank? && (self.updated_at < (Date.today - 30))
      false #PAST_30_DAYS
    elsif !self.blank?
      true # APPROVED
    else
      false #NO RECORD
    end
  end

  def refund_desc

    if (!self.blank? && !self.amount_refunded.blank?)
        "Already refunded payment, please contact support for help!"
    elsif !self.blank? && (self.updated_at < (Date.today - 30))
        "You upgraded to premium more than 30 days ago, not eligble for a refund!"
    elsif !self.blank?
        "Approved"
    else
        "No record of your transaction, contact support for help!"
    end
  end

  def unprocessed_refund?
  
    if !self.blank?
      if self.amount_refunded.blank? && !self.amount_billed.blank? && self.updated_at <= (Date.today - 30.days)
        true
      else
        false
      end
    else
       false
    end

  end

  def last_90days_refund?

    if !self.blank?
      if self.updated_at >= (Date.today - 90.days) && !self.amount_refunded.blank?
        true
      else
        false
      end
    else
        false
    end

  end





end
