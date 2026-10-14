puts "Preparando configuración y actividades del club..."

ClubSetting.first_or_create!(base_fee: 25_000.0)

User.find_or_create_by!(email: "admin@club.com") do |user|
  user.password = "password123"
  user.role = :admin
end

activities = [
  { name: "Fútbol 11 (Amateur)", description: "Partidos los fines de semana en césped natural.", monthly_fee: 15_000.0, capacity: 50, active: true },
  { name: "Natación Libre", description: "Acceso a la pileta climatizada en los horarios habilitados.", monthly_fee: 18_000.0, capacity: 30, active: true },
  { name: "Básquet", description: "Entrenamientos y partidos recreativos para adultos.", monthly_fee: 15_000.0, capacity: 20, active: true },
  { name: "Vóley", description: "Entrenamientos semanales para nivel inicial e intermedio.", monthly_fee: 14_000.0, capacity: 18, active: true },
  { name: "Tenis", description: "Clases grupales y turnos en las canchas del club.", monthly_fee: 20_000.0, capacity: 12, active: true },
  { name: "Hockey", description: "Entrenamientos y encuentros recreativos en cancha.", monthly_fee: 17_000.0, capacity: 22, active: true },
  { name: "Musculación", description: "Uso del gimnasio con rutinas de entrenamiento general.", monthly_fee: 18_000.0, capacity: 35, active: true },
  { name: "Yoga", description: "Clases grupales para movilidad, respiración y relajación.", monthly_fee: 12_000.0, capacity: 20, active: true }
]

activities.each do |attributes|
  Activity.find_or_create_by!(name: attributes[:name]) do |activity|
    activity.assign_attributes(attributes)
  end
end

puts "Creando socio de ejemplo si todavía no existe..."
socio_user = User.find_or_create_by!(email: "socio@club.com") do |user|
  user.password = "password123"
  user.role = :member
end

profile = MemberProfile.find_or_create_by!(user: socio_user) do |member_profile|
  member_profile.assign_attributes(
    first_name: "Lionel",
    last_name: "Messi",
    dni: "10101010",
    birth_date: Date.new(1987, 6, 24)
  )
end

futbol = Activity.find_by!(name: "Fútbol 11 (Amateur)")
Enrollment.find_or_create_by!(member_profile: profile, activity: futbol) do |enrollment|
  enrollment.start_date = Date.current
end

MembershipFee.find_or_create_by!(member_profile: profile, due_date: Date.current.end_of_month) do |fee|
  fee.status = :pending
end

puts "Actividades del club listas."
