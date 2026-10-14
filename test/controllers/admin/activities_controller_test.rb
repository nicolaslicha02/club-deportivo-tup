require "test_helper"

class Admin::ActivitiesControllerTest < ActionDispatch::IntegrationTest
  test "vincula cada actividad con los socios inscriptos" do
    member = User.create!(email: "socio-admin@example.com", password: "password", role: :member)
    profile = MemberProfile.create!(user: member, first_name: "Socio", last_name: "Visible", dni: "30000007", birth_date: Date.new(1990, 1, 1))
    activity = Activity.create!(name: "Actividad de prueba", capacity: 5, monthly_fee: 500, active: true)
    Enrollment.create!(activity: activity, member_profile: profile, start_date: Date.current)

    assert_equal [profile], activity.member_profiles.to_a
  end
end
