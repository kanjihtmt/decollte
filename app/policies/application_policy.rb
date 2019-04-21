class ApplicationPolicy
  attr_reader :administrator, :record

  def initialize(administrator, record)
    @administrator = administrator
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :administrator, :scope

    def initialize(administrator, scope)
      @administrator = administrator
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
