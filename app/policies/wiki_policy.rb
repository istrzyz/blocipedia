class WikiPolicy < ApplicationPolicy

  def index?
    user.present? && record.user == user
  end

  def show?
    user.present?
  end

  def new?
    user.present?
  end
end
