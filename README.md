# Club Deportivo - Sistema de Gestión

Aplicación web desarrollada con Ruby on Rails para administrar socios, actividades deportivas, inscripciones y cuotas mensuales. Incluye un panel de administración y un portal de autogestión para los socios.

## Funcionalidades

### Panel de administración

- Consulta de actividades, cupos disponibles y socios inscriptos.
- Consulta del padrón de socios.
- Revisión de comprobantes de pago con estados claros: esperando pago, a revisar, aprobada y rechazada.
- Al rechazar un comprobante, el administrador debe indicar el motivo. El socio puede corregirlo y volver a enviarlo.
- Configuración del valor base de la cuota del club.

### Portal de socios

- Consulta de datos personales y número de socio.
- Inscripción a actividades activas con cupo disponible.
- Consulta de cuotas y envío de comprobantes de pago.
- Avisos por correo al registrarse, inscribirse en una actividad y recibir una resolución sobre un pago.

## Tecnologías

- Ruby on Rails
- SQLite3
- HTML, CSS y Bootstrap 5
- Turbo y Active Storage
- Action Mailer

## Instalación local

Se requiere Ruby y Bundler instalados. Desde la carpeta del proyecto:

```powershell
bundle install
bundle exec ruby .\bin\rails db:prepare
bundle exec ruby .\bin\rails server
```

Luego abrir `http://localhost:3000`.

## Correo electrónico

En producción, configura estas variables de entorno con los datos de tu proveedor SMTP:

- `SMTP_ADDRESS`
- `SMTP_PORT` (por defecto `587`)
- `SMTP_DOMAIN` (por defecto usa `SMTP_ADDRESS`)
- `SMTP_USERNAME`
- `SMTP_PASSWORD`
- `MAILER_FROM` (por defecto `no-reply@clubdeportivo.com`)

## Pruebas

Ejecuta la suite con:

```powershell
bundle exec ruby .\bin\rails test
```

Si Rails informa que faltan migraciones, prepara la base de datos con `bundle exec ruby .\bin\rails db:prepare`.

## Credenciales de prueba

Si las semillas crean estos usuarios, puedes iniciar sesión con:

**Administrador**

- Email: `admin@club.com`
- Contraseña: `password123`

**Socio**

- Email: `socio@club.com`
- Contraseña: `password123`

## Autor

Máximo Nicolás Licha — Tecnicatura Universitaria en Programación (TUP), UTN Facultad Regional La Plata.
