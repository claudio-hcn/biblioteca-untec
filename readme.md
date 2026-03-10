# 📚 Biblioteca UNTEC

Sistema de gestión web para la biblioteca digital de la Universidad UNTEC. Permite gestionar libros, usuarios y préstamos de forma online, reemplazando el catálogo manual existente.

---

## 🛠️ Tecnologías Utilizadas

- **Java 17** → lenguaje principal
- **Jakarta Servlets + JSP** → capa web
- **JSTL** → etiquetas en las vistas JSP
- **Maven** → gestión de dependencias y empaquetado
- **JDBC** → acceso a base de datos
- **MySQL** → motor de base de datos
- **Apache Tomcat 10** → servidor de aplicaciones
- **BCrypt** → encriptación de contraseñas
- **Patrón MVC** → arquitectura de la aplicación

---

## 📁 Estructura del Proyecto

```
biblioteca-untec/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/untec/biblioteca/
│       │       ├── dao/              ← acceso a base de datos
│       │       │   ├── ConexionDB.java
│       │       │   ├── LibroDAO.java
│       │       │   ├── UsuarioDAO.java
│       │       │   └── PrestamoDAO.java
│       │       ├── model/            ← clases de datos
│       │       │   ├── Libro.java
│       │       │   ├── Usuario.java
│       │       │   └── Prestamo.java
│       │       ├── servlet/          ← controladores
│       │       │   ├── LoginServlet.java
│       │       │   ├── LogoutServlet.java
│       │       │   ├── RegistroServlet.java
│       │       │   ├── LibroServlet.java
│       │       │   ├── UsuarioServlet.java
│       │       │   ├── PrestamoServlet.java
│       │       │   ├── CatalogoServlet.java
│       │       │   ├── AdminDashboardServlet.java
│       │       │   ├── AdminPrestamoServlet.java
│       │       │   ├── UsuarioDashboardServlet.java
│       │       │   └── PerfilServlet.java
│       │       └── util/             ← utilidades
│       │           └── Validador.java
│       └── webapp/
│           ├── WEB-INF/
│           │   └── web.xml
│           ├── views/
│           │   ├── admin/
│           │   │   ├── dashboard.jsp
│           │   │   ├── libros.jsp
│           │   │   ├── libro-form.jsp
│           │   │   ├── usuarios.jsp
│           │   │   └── historial.jsp
│           │   └── usuario/
│           │       ├── dashboard.jsp
│           │       ├── catalogo.jsp
│           │       ├── prestamos.jsp
│           │       └── perfil.jsp
│           ├── login.jsp
│           └── registro.jsp
└── pom.xml
```

---

## 🗄️ Base de Datos

**Nombre:** `biblioteca_untec`

### Tablas

#### `usuarios`
| Campo | Tipo | Descripción |
|---|---|---|
| id_usuario | INT PK AUTO_INCREMENT | Identificador único |
| nombre | VARCHAR(100) | Nombre completo |
| rut | VARCHAR(12) UNIQUE | RUT chileno |
| email | VARCHAR(100) UNIQUE | Correo electrónico |
| password | VARCHAR(255) | Contraseña encriptada con BCrypt |
| carrera | VARCHAR(100) | Carrera universitaria |
| fecha_nacimiento | DATE | Fecha de nacimiento |
| rol | ENUM('ADMIN','USUARIO') | Rol en el sistema |
| activo | BOOLEAN | Estado de la cuenta |

#### `libros`
| Campo | Tipo | Descripción |
|---|---|---|
| id_libro | INT PK AUTO_INCREMENT | Identificador único |
| isbn | VARCHAR(20) UNIQUE | Código ISBN mundial |
| titulo | VARCHAR(200) | Título del libro |
| autor | VARCHAR(100) | Autor |
| anio_publicacion | YEAR | Año de publicación |
| editorial | VARCHAR(100) | Editorial |
| categoria | VARCHAR(50) | Categoría o género |
| disponible | BOOLEAN | Disponibilidad para préstamo |

#### `prestamos`
| Campo | Tipo | Descripción |
|---|---|---|
| id_prestamo | INT PK AUTO_INCREMENT | Identificador único |
| id_usuario | INT FK | Referencia a usuarios |
| id_libro | INT FK | Referencia a libros |
| fecha_prestamo | DATE | Fecha de solicitud |
| fecha_limite | DATE | Plazo máximo de devolución |
| fecha_devolucion | DATE | Fecha real de devolución (NULL si activo) |
| estado | ENUM('ACTIVO','DEVUELTO','ATRASADO') | Estado del préstamo |

---

## ⚙️ Configuración

### 1. Base de datos

Ejecutar en MySQL Workbench:

```sql
CREATE DATABASE biblioteca_untec;
USE biblioteca_untec;

-- Crear usuario de BD
CREATE USER 'biblioteca_user'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca_untec.* TO 'biblioteca_user'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Conexión

Editar `src/main/java/com/untec/biblioteca/dao/ConexionDB.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/biblioteca_untec";
private static final String USER = "biblioteca_user";
private static final String PASSWORD = "password123";
```

### 3. Compilar y empaquetar

```bash
mvn clean package
```

### 4. Desplegar

Copiar `target/biblioteca-untec.war` a la carpeta `webapps/` de Tomcat.

### 5. Acceder

```
http://localhost:8080/biblioteca-untec/login
```

---

## 👤 Credenciales de Prueba

| Rol | Email | Contraseña |
|---|---|---|
| ADMIN | admin@untec.cl | admin123 |
| USUARIO | maria.gonzalez@untec.cl | admin123 |

---

## 🔐 Seguridad

- Contraseñas encriptadas con **BCrypt**
- Protección contra **SQL Injection** con `PreparedStatement`
- **Protección de rutas** → redirige al login si no hay sesión activa
- **Control de roles** → ADMIN y USUARIO con accesos diferenciados
- **Validación de RUT chileno** con algoritmo de dígito verificador
- **Cuentas bloqueables** por el administrador

---

## ✨ Funcionalidades

### ADMIN
- Dashboard con estadísticas en tiempo real
- Gestión completa de libros (CRUD)
- Gestión de usuarios (listar, bloquear, desbloquear, eliminar)
- Historial de todos los préstamos con buscador

### USUARIO
- Dashboard con préstamos activos
- Catálogo de libros con buscador en tiempo real
- Solicitar y devolver préstamos
- Cálculo automático de fecha límite en **7 días hábiles**
- Editar perfil personal

---

## 📦 Dependencias principales

```xml
<!-- Servlets y JSP -->
jakarta.servlet-api 5.0.0
jakarta.servlet.jsp-api 3.0.0

<!-- JSTL -->
jakarta.servlet.jsp.jstl 2.0.0

<!-- MySQL -->
mysql-connector-java 8.0.33

<!-- BCrypt -->
jbcrypt 0.4
```

---

## 👨‍💻 Desarrollado por

**Claudio** — Bootcamp Java TD  
Universidad UNTEC — 2026