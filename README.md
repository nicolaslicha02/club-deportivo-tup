# Club Deportivo - Sistema de Gestión

Una aplicación web desarrollada en Ruby on Rails diseñada para administrar las operaciones diarias de un club deportivo. El sistema permite gestionar actividades, socios y el cobro de cuotas mensuales a través de dos interfaces principales: un panel de administración y un portal de autogestión para los miembros.

## Características Principales

*   **Autenticación y Roles:** Sistema de inicio de sesión unificado con redirección inteligente basada en roles (Administrador y Socio).
*   **Panel de Administración:**
    *   Gestión de actividades deportivas (creación, edición y asignación de cupos).
    *   Visualización del padrón de socios.
    *   Control y verificación de pagos: revisión de comprobantes adjuntados y aprobación o rechazo de cuotas.
*   **Portal de Autogestión (Socios):**
    *   Visualización de datos personales y número de socio autogenerado.
    *   Inscripción a nuevas disciplinas deportivas con actualización automática del estado de cuenta.
    *   Panel de facturación para visualizar cuotas pendientes y subir comprobantes de pago (imágenes/PDF).
*   **Configuración Global:** Manejo dinámico del valor de la cuota base del club.

## Tecnologías Utilizadas

*   **Backend:** Ruby on Rails 7
*   **Base de Datos:** SQLite3
*   **Frontend:** HTML5, CSS3, Bootstrap 5.3
*   **Interacciones:** Turbo (Hotwire) para navegación fluida y ActiveStorage para el manejo de archivos.

## Instalación y Configuración Local

Para correr este proyecto en tu entorno local, asegurate de tener instalado Ruby y Rails, y seguí estos pasos:

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/TU-USUARIO/club-deportivo-tup.git](https://github.com/TU-USUARIO/club-deportivo-tup.git)
    cd club-deportivo-tup
    ```

2.  **Instalar las dependencias:**
    ```bash
    bundle install
    ```

3.  **Preparar la base de datos:**
    Este comando creará la base de datos, ejecutará las migraciones y cargará los datos de prueba iniciales (semillas):
    ```bash
    rails db:setup
    ```

4.  **Iniciar el servidor local:**
    ```bash
    rails server
    ```
    El sistema estará disponible en `http://localhost:3000`.

## Credenciales de Prueba

La base de datos se inicializa con dos usuarios predeterminados para probar los distintos roles del sistema:

**Administrador:**
*   **Email:** `admin@club.com`
*   **Contraseña:** `password123`

**Socio (Portal de autogestión):**
*   **Email:** `socio@club.com`
*   **Contraseña:** `password123`

## Autor

**Máximo Nicolás Licha**  
Proyecto desarrollado en el marco de la Tecnicatura Universitaria en Programación (TUP)  
Universidad Tecnológica Nacional Facultad Regional La Plata (UTN FRLP)
