class ActivitiesController < ApplicationController

  def index
    scope = Activity.order(occured_at: :desc)

    @activities = scope.page(params[:page].to_i).per(5)
  end

end
