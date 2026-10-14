require "test_helper"

class Portal::ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      email: "socio@example.com",
      password: "password",
      role: :member,
      member_profile_attributes: {
        first_name: "Ana", last_name: "Pérez", dni: "30111222", birth_date: Date.new(1995, 1, 1)
      }
    )
    post login_path, params: { email: @user.email, password: "password" }
  end

  test "inscribe al socio, actualiza su cuota y envía confirmación" do
    activity = Activity.create!(name: "Vóley", capacity: 1, monthly_fee: 5000, active: true)

    assert_difference("Enrollment.count", 1) do
      assert_difference("ActionMailer::Base.deliveries.count", 1) do
        post enroll_portal_activity_path(activity)
      end
    end

    assert_redirected_to portal_dashboard_path
    assert_equal @user.email, ActionMailer::Base.deliveries.last.to.first
    assert_equal "Vóley", @user.member_profile.activities.last.name
  end

  test "rechaza la inscripción cuando la actividad está completa" do
    activity = Activity.create!(name: "Básquet", capacity: 1, monthly_fee: 5000, active: true)
    other_profile = MemberProfile.create!(user: User.create!(email: "otro@example.com", password: "password", role: :member), first_name: "Luis", last_name: "Díaz", dni: "30111223", birth_date: Date.new(1995, 1, 1))
    Enrollment.create!(member_profile: other_profile, activity: activity, start_date: Date.current)

    assert_no_difference("Enrollment.count") do
      post enroll_portal_activity_path(activity)
    end

    assert_redirected_to portal_activities_path
    assert_equal "La actividad ya no está disponible o no tiene cupos.", flash[:alert]
  end
end
