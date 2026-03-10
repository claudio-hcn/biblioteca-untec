<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin - Biblioteca UNTEC</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar {
            background: #4a90e2;
            color: white;
            padding: 16px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a { color: white; text-decoration: none; margin-left: 16px; }
        .container { padding: 24px; max-width: 1200px; margin: 0 auto; }
        h2 { margin-bottom: 24px; color: #333; }
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }
        .card {
            background: white;
            border-radius: 8px;
            padding: 24px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .card .numero {
            font-size: 48px;
            font-weight: bold;
            margin: 8px 0;
        }
        .card p { color: #666; font-size: 14px; }
        .card.azul .numero { color: #4a90e2; }
        .card.verde .numero { color: #28a745; }
        .card.rojo .numero  { color: #e74c3c; }
        .card.gris .numero  { color: #6c757d; }
        .accesos {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 16px;
        }
        .acceso {
            background: white;
            border-radius: 8px;
            padding: 24px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            text-decoration: none;
            color: #333;
            transition: transform 0.2s;
        }
        .acceso:hover { transform: translateY(-4px); }
        .acceso .icono { font-size: 36px; margin-bottom: 8px; }
        .acceso p { font-size: 14px; color: #666; }
    </style>
</head>
<body>
    <div class="navbar">
        <span>📚 Biblioteca UNTEC - Admin</span>
        <div>
            <a href="<%=request.getContextPath()%>/admin/libros">Libros</a>
            <a href="<%=request.getContextPath()%>/admin/historial">Historial</a>
            <a href="<%=request.getContextPath()%>/logout">Cerrar sesión</a>
        </div>
    </div>

    <div class="container">
        <h2>👋 Bienvenido, ${sessionScope.usuarioLogueado.nombre}</h2>

        <div class="cards">
            <div class="card azul">
                <p>📚 Total Libros</p>
                <div class="numero">${totalLibros}</div>
                <p>en el sistema</p>
            </div>
            <div class="card verde">
                <p>🔄 Préstamos Activos</p>
                <div class="numero">${totalActivos}</div>
                <p>libros prestados</p>
            </div>
            <div class="card rojo">
                <p>⚠️ Atrasados</p>
                <div class="numero">${totalAtrasados}</div>
                <p>fuera de plazo</p>
            </div>
            <div class="card gris">
                <p>👤 Usuarios</p>
                <div class="numero">${totalUsuarios}</div>
                <p>registrados</p>
            </div>
        </div>

        <h3 style="margin-bottom:16px; color:#333;">Accesos Rápidos</h3>
        <div class="accesos">
            <a href="<%=request.getContextPath()%>/admin/libros" class="acceso">
                <div class="icono">📚</div>
                <strong>Gestionar Libros</strong>
                <p>Agregar, editar o eliminar libros</p>
            </a>
            <a href="<%=request.getContextPath()%>/admin/historial" class="acceso">
                <div class="icono">📋</div>
                <strong>Historial Préstamos</strong>
                <p>Ver todos los préstamos</p>
            </a>
            <a href="<%=request.getContextPath()%>/admin/usuarios" class="acceso">
                <div class="icono">👤</div>
                <strong>Gestionar Usuarios</strong>
                <p>Agregar, editar o eliminar usuarios</p></a>
            
        </div>
    </div>
</body>
</html>