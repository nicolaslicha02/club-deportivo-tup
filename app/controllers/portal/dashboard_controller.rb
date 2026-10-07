class Portal::DashboardController < ApplicationController
  def index
    @profile = current_user.member_profile
    @activities = @profile.activities
    @pending_fees = @profile.membership_fees.where(status: :pending)
  end
end
