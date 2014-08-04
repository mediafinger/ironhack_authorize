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
end
