require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  test "no debe guardar una actividad sin nombre" do
    activity = Activity.new(capacity: 20, monthly_fee: 10000, active: true)
    assert_not activity.save, "Guardó la actividad sin un nombre"
  end

  test "no debe guardar una actividad con cupo negativo" do
    activity = Activity.new(name: "Tenis", capacity: -5, monthly_fee: 15000, active: true)
    assert_not activity.save, "Guardó la actividad con capacidad negativa"
  end

  test "debe guardar una actividad válida" do
    activity = Activity.new(name: "Tenis", description: "Clases", capacity: 10, monthly_fee: 15000, active: true)
    assert activity.save, "No pudo guardar una actividad válida"
  end

  test "calcula los cupos disponibles descontando las inscripciones" do
    activity = Activity.create!(name: "Handball", capacity: 2, monthly_fee: 1000, active: true)
    Enrollment.create!(member_profile: create_profile("capacidad@example.com", "30000001"), activity: activity, start_date: Date.current)

    assert_equal 1, activity.available_spots
  end

  test "no permite inscribir más socios que el cupo" do
    activity = Activity.create!(name: "Natación", capacity: 1, monthly_fee: 1000, active: true)
    Enrollment.create!(member_profile: create_profile("primero@example.com", "30000002"), activity: activity, start_date: Date.current)
    second_enrollment = Enrollment.new(member_profile: create_profile("segundo@example.com", "30000003"), activity: activity, start_date: Date.current)

    assert_not second_enrollment.valid?
    assert_includes second_enrollment.errors[:base], "La actividad no tiene cupos disponibles"
  end

  private

  def create_profile(email, dni)
    user = User.create!(email: email, password: "password123", role: :member)
    MemberProfile.create!(user: user, first_name: "Socio", last_name: "Prueba", dni: dni, birth_date: Date.new(1990, 1, 1))
  end
end
