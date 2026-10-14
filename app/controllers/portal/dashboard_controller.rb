class Portal::DashboardController < ApplicationController
  def index
    @profile = current_user.member_profile
    @activities = @profile.activities.order(:name)
    @pending_fees = @profile.membership_fees.where(status: [ :pending, :rejected ]).order(due_date: :asc)
    @fees_under_review = @profile.membership_fees.under_review.order(due_date: :asc)
    @recent_fees = @profile.membership_fees.order(due_date: :desc).limit(5)
  end
end
