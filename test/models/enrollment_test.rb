require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  test "requiere fecha de inicio" do
    enrollment = Enrollment.new(member_profile: create_profile("fecha@example.com", "30000004"), activity: create_activity("Fecha"))

    assert_not enrollment.valid?
    assert_includes enrollment.errors[:start_date], "can't be blank"
  end

  test "evita inscribir dos veces al mismo socio en una actividad" do
    profile = create_profile("duplicado@example.com", "30000005")
    activity = create_activity("Duplicada")
    Enrollment.create!(member_profile: profile, activity: activity, start_date: Date.current)
    enrollment = Enrollment.new(member_profile: profile, activity: activity, start_date: Date.current)

    assert_not enrollment.valid?
    assert_includes enrollment.errors[:activity_id], "el socio ya está inscripto en esta actividad"
  end

  test "crea una inscripción cuando hay lugar y no existe otra igual" do
    activity = create_activity("Yoga")
    enrollment = Enrollment.new(member_profile: create_profile("yoga@example.com", "30000006"), activity: activity, start_date: Date.current)

    assert enrollment.save
  end

  private

  def create_activity(name)
    Activity.create!(name: name, capacity: 2, monthly_fee: 500, active: true)
  end

  def create_profile(email, dni)
    user = User.create!(email: email, password: "password123", role: :member)
    MemberProfile.create!(user: user, first_name: "Socio", last_name: "Prueba", dni: dni, birth_date: Date.new(1990, 1, 1))
  end
end
