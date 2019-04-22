class BrandPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    administrator.admin?
  end

  def new?
    create?
  end
end
