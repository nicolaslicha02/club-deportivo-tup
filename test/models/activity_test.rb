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
end
