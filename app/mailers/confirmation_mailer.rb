class ConfirmationMailer < ApplicationMailer
  default from: "youremail@email.com"

  def new_user(user)

     @user = user


     mail(to: user.email, subject: "Welcome to Blocipedia")
   end
end
