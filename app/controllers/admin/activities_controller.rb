class Admin::ActivitiesController < Admin::BaseController
  def index
    @activities = Activity.includes(enrollments: { member_profile: :user }).order(:name)
  end
end
