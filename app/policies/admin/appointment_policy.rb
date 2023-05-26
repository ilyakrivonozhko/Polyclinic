module Admin
  class AppointmentPolicy<ApplicationPolicy
    def create?
      user.admin_role? || user.medic_role? || user.receptionist_role?
    end

    def update?
      false
    end

    def index?
      user.admin_role? || user.medic_role? || user.receptionist_role?
    end

    def destroy?
      user.admin_role? || user.medic_role? || user.receptionist_role?
    end

    def show?
      false
    end
  end
end