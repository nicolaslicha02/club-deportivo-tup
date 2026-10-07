puts "Limpiando la base de datos..."
Enrollment.destroy_all
MembershipFee.destroy_all
Activity.destroy_all
MemberProfile.destroy_all
User.destroy_all
ClubSetting.destroy_all

puts "Creando Configuración Global..."
ClubSetting.create!(base_fee: 25000.0)

puts "Creando Administrador..."
# Quitamos la variable "admin =" para evitar la advertencia del editor
User.create!(
  email: "admin@club.com",
  password: "password123",
  role: 0
)

puts "Creando Actividades de prueba..."
futbol = Activity.create!(
  name: "Fútbol 11 (Amateur)",
  description: "Partidos fines de semana en césped natural.",
  monthly_fee: 15000.0,
  capacity: 50,
  active: true
)

# Quitamos la variable "natacion =" para evitar la advertencia del editor
Activity.create!(
  name: "Natación Libre",
  description: "Pileta climatizada olímpica.",
  monthly_fee: 18000.0,
  capacity: 30,
  active: true
)

puts "Creando Socio de prueba..."
socio_user = User.create!(
  email: "socio@club.com",
  password: "password123",
  role: 1
)

perfil = socio_user.create_member_profile!(
  first_name: "Lionel",
  last_name: "Messi",
  dni: "10101010",
  birth_date: "1987-06-24"
)

# Anotamos al socio en fútbol pasándole la fecha de inicio requerida
Enrollment.create!(
  member_profile: perfil,
  activity: futbol,
  start_date: Date.today
)

# Le generamos su primera cuota pendiente
MembershipFee.create!(
  member_profile: perfil,
  due_date: Date.today.end_of_month,
  status: "pending"
)

puts "Base de datos inicializada con éxito."
