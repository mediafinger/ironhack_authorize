class ProjectPolicy < ApplicationPolicy

  def index?
    if user.admin? || user.po?
      true
    elsif user.developer?
      (record - user.projects).empty?
    end
  end

  def create?
    user.admin? || user.po?
  end

  # the pundit way of scoping - can be called like this:
  # Pundit.policy_scope(user, Project.scope) - from everywhere, or
  # policy_scope(Project.scope)  - from the controller
  class Scope < Struct.new(:user, :scope)

    def resolve
      if user.admin? || user.po?
        scope
      elsif user.developer?
        user.projects
      end
    end

  end

end
