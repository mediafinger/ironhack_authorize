class TaskPolicy < ApplicationPolicy

  # not used yet, included as example
  def index?
    if user.admin? || user.po?
      true
    elsif user.developer?
      (scope - user.tasks).empty?
    end
  end

  def create?
    true
  end

  # not used yet, included as example
  def show?
    user.admin? || user.po? || user.tasks.find(record.id)
  end

  def update?
    user.admin? || user.tasks.find(record.id)
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
        user.tasks
      end
    end

  end

end
