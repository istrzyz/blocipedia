class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  after_create :send_favorite_emails

  private
    def send_user_emails
      user.new.each do |new|
        ConfirmationMailer.new_user(new.user, self).deliver_now
      end
    end
end
