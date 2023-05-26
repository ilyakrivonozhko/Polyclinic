class AppointmentPolicy<ApplicationPolicy
  def create?
    true
  end

  def update?
    false
  end

  def index?
    !user.guest?
  end

  def destroy?
    record == user || user.admin_role? || user.medic_role? || user.receptionist_role?
  end

  def show?
    false
  end
end