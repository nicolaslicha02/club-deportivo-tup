class Admin::ActivitiesController < Admin::BaseController
  def index
    @activities = Activity.all
  end
end
