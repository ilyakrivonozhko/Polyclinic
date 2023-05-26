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
    record.user == user 
  end

  def show?
    false
  end
end