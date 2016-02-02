class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :visible_to, -> (user) {user ? all : where(public: true)}

  def public?
    private == false
  end

  def owner
    User.find(self.user_id) if self.user_id
  end

end
