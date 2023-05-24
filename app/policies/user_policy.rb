class UserPolicy<ApplicationPolicy
  def create?
    user.guest?
  end

  def update?
    record == user
  end

  def index?
    false
  end

  def destroy?
    false
  end

  def show?
    record == user || user.admin_role? || user.medic_role?
  end
end