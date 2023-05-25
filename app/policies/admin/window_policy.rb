module Admin
  class WindowPolicy<ApplicationPolicy
    def index?
      user.admin_role?
    end

    def create?
      user.admin_role?
    end

    def update?
      false
    end

    def destroy?
      user.admin_role?
    end

    def show?
      false
    end
  end
end