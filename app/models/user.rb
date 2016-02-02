class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # before_create { self.role ||= :standard}
  # after_create :send_favorite_emails

  def admin?
    role == "admin"
  end

  def standard?
    role == "standard"
  end

  def premium?
    role == "premium"
  end

  def get_role
    return "(Admin)" if self.admin?
    self.premium? ? "(Premium)" : "(Standard)"
  end

  private
    def send_user_emails
      user.new.each do |new|
        ConfirmationMailer.new_user(new.user, self).deliver_now
      end
    end
end
