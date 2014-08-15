class TaskPolicy < ApplicationPolicy

  def create?
    true
  end

  # not used yet, included as example
  def show?
    user.admin? || user.po? || record.user == user
  end

  def update?
    user.admin? || record.user == user
  end

  # not used yet, included as example
  def destroy?
    user.admin?
  end


  # the pundit way of scoping - can be called like this:
  # Pundit.policy_scope(user, Task.scope) - from everywhere, or
  # policy_scope(Task.scope)  - from the controller
  class Scope < Struct.new(:user, :scope)

    def resolve
      if user.admin? || user.po?
        scope
      elsif user.developer?
        scope.where(id: user.tasks.pluck(:id))
      end
    end

  end

end
