class AppointmentPolicy<ApplicationPolicy
  def create?
    user.basic_role?
  end

  def update?
    false
  end

  def index?
    user.basic_role?
  end

  def destroy?
    record.user == user 
  end

  def show?
    false
  end
end