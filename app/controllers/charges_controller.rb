class ChargesController < ApplicationController

  def create
    # create an amount and set default amount
    # amount in pennies format is dd_pp

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the magic happens!

    charge = Stripe::Charge.create(
      customer: customer.id, # NOT the same as user_id in app
      amount: 15_00,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd'
   )

    # upgrade role to premium
    current_user.role = "premium"

    flash[:notice] = "Thanks, #{current_user.email}! As a #{current_user.role} member, now you can make private wikis."
    redirect_to root_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This 'rescue block' catches and displays those errors.

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership",
      amount: 15_00
    }
  end
end
