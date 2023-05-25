class AppointmentPolicy<ApplicationPolicy
  def create?
    false
  end

  def update?
    false
  end

  def index?
    !user.guest?
  end

  def destroy?
    false
  end

  def show?
    false
  end
end