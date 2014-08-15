class ProjectPolicy < ApplicationPolicy

  def create?
    user.admin? || user.po?
  end

  # not used yet, included as example
  def show?
    user.admin? || user.po? || record.user == user
  end

  # not used yet, included as example
  def update?
    user.admin?
  end

  # not used yet, included as example
  def destroy?
    update?
  end


  # the pundit way of scoping - can be called like this:
  # Pundit.policy_scope(user, Project.scope) - from everywhere, or
  # policy_scope(Project.scope)  - from the controller
  class Scope < Struct.new(:user, :scope)

    def resolve
      if user.admin? || user.po?
        scope
      elsif user.developer?
        scope.where(id: user.projects.pluck(:id))
      end
    end

  end

end
