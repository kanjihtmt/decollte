class AdministratorPolicy < ApplicationPolicy
  def index?
    administrator.admin?
  end

  def create?
    administrator.admin?
  end

  def new?
    create?
  end

  def update?
    administrator.admin?
  end

  def edit?
    update?
  end

  def destroy?
    administrator.admin?
  end
end
