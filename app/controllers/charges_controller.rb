require 'date'
include ChargesHelper

class ChargesController < ApplicationController
before_action :authenticate_user!

  def show
    @user = current_user
    @amount = Amount.find_by(user_id: current_user.id)

    @refund_status = validate_refund(@amount)

    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Downgrade",
    }

  end

  def new

    @user = current_user
    @amount = Amount.find_by(user_id: current_user.id)

    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Upgrade",
     amount: Amount.default
    }

  end


  def create

     @amount = Amount.find_by(user_id: current_user.id)
     authorize Amount

     # Checking if somehow money was not refunded due to the account
     # being downgraded but not refunded, exclude if past 30 days
     if @amount != nil
        if @amount.amount_refunded == 0 && @amount.amount_billed != nil && @amount.updated_at <= (Date.today - 30.days)
          flash[:notice] = "Unable to upgrade account, please email support!"
          redirect_to users_show_path(current_user)
          return
     # Giving free upgrades if they prevsiouly paid in the last 90 days and did not recieve a refund
        elsif @amount.updated_at >= (Date.today - 90.days) && @amount.amount_refunded == 0
          byebug
          current_user.premium!
          current_user.save
          flash[:notice] = "No charge since you upgraded previously in the last 90 days"
          redirect_to users_show_path(current_user)
          return
        end

      end

     # Creates a Stripe Customer object, for associating
     # with the charge
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
     )

     # Where the real magic happens
     charge = Stripe::Charge.create(
       customer: customer.id, # Note -- this is NOT the user_id in your app
       amount: Amount.default,
       description: "Premium Membership - #{current_user.email}",
       currency: 'usd'
     )

     # upgrade the account and store needed charge information

     current_user.premium!
     current_user.save
     @amount = Amount.new if @amount == nil
     @amount.charge_amt = Amount.default
     @amount.user_id = current_user.id
     @amount.charge_id = charge.id
     @amount.amount_billed = charge.amount
     @amount.save

     flash[:notice] = "Thank you, #{current_user.email}. You are now ready to starting enjoy the benefits of being a premium account holder."
     redirect_to users_show_path(current_user)

     # Stripe will send back CardErrors, with friendly messages
     # when something goes wrong.
     # This `rescue block` catches and displays those errors.
     rescue Stripe::CardError => e
       flash[:error] = e.message
       redirect_to new_charge_path
     end


     def destroy

        authorize Amount
        @amount = Amount.find_by(user_id: current_user.id)

        if @refund_status == APPROVED
          customer = Stripe::Refund.create(
            charge: @amount.charge_id,
          )
          @amount.amount_refunded = customer.amount
          @amount.save
          amount_refunded = customer.amount / 100
        end

        # Downgrade the account to standard and update the amount refunded
        current_user.standard!
        current_user.save

        flash[:notice] = "Thank you, #{current_user.email}. You account has been downgraded to a standard account and #{amount_refunded} has been refunded."
        redirect_to users_show_path(current_user)

        # Stripe will send back CardErrors, with friendly messages
        # when something goes wrong.
        # This `rescue block` catches and displays those errors.
      rescue Stripe::StripeError => e
          flash[:error] = e.message
          redirect_to new_charge_path
        end

#     rescue => e
#       flash[:error] = "Refund failure, please contact support!"
#       redirect_to new_charge_path
#     end



end
