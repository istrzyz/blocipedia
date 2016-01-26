class ChargesController < ApplicationController

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to user_path(current_user) # or wherever

  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: 10000
    }
  end

  def destroy



#    @wiki = Wiki.find(params[:id])
#    if @wiki.destroy
#      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
#      redirect_to wikis_path
#    else
#      flash.now[:alert] = "There was an error deleting this wiki"
#      render :show
#    end
    #cancel stripe
    current_user.
    # make user standard
    current_user.update_attributes(role: 'standard')
    # make wikis public
    current_user.make_wikis_public
    # redirect
    redirect_to edit_user_registration_path
  end
end
