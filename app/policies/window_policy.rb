class WindowPolicy<ApplicationPolicy
  def index?
    user.medic_role?
  end

  def create?
    user.medic_role?
  end

  def update?
    false
  end

  def destroy?
    record == user #|| user.amdin_role?
  end

  def show?
    false
  end
end