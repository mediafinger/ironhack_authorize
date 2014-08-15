class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all.limit(25).order(occured_at: :desc)
  end

end
