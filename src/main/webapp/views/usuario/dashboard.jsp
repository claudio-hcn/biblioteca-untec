<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Biblioteca UNTEC</title>
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
        h2 { margin-bottom: 8px; color: #333; }
        h3 { margin-bottom: 16px; color: #333; margin-top: 32px; }
        .subtitulo { color: #666; margin-bottom: 24px; font-size: 14px; }
        .accesos {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
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
        .acceso p { font-size: 13px; color: #666; }
        table {
            width: 100%;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-collapse: collapse;
        }
        th {
            background: #4a90e2;
            color: white;
            padding: 12px 16px;
            text-align: left;
            font-size: 14px;
        }
        td { padding: 12px 16px; border-bottom: 1px solid #eee; font-size: 14px; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #f9f9f9; }
        .badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger  { background: #f8d7da; color: #721c24; }
        .badge-success { background: #d4edda; color: #155724; }
        .empty {
            text-align: center;
            padding: 40px;
            color: #888;
            background: white;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <span>📚 Biblioteca UNTEC</span>
        <div>
            <a href="<%=request.getContextPath()%>/usuario/catalogo">Catálogo</a>
            <a href="<%=request.getContextPath()%>/usuario/prestamos">Mis Préstamos</a>
            <a href="<%=request.getContextPath()%>/logout">Cerrar sesión</a>
        </div>
    </div>

    <div class="container">
        <h2>👋 Bienvenido, ${sessionScope.usuarioLogueado.nombre}</h2>
        <p class="subtitulo">${sessionScope.usuarioLogueado.carrera}</p>

        <div class="accesos">
            <a href="<%=request.getContextPath()%>/usuario/catalogo" class="acceso">
                <div class="icono">📚</div>
                <strong>Catálogo</strong>
                <p>Buscar y solicitar libros</p>
            </a>
            <a href="<%=request.getContextPath()%>/usuario/prestamos" class="acceso">
                <div class="icono">📋</div>
                <strong>Mis Préstamos</strong>
                <p>Ver y devolver libros</p>
            </a>
            <a href="<%=request.getContextPath()%>/usuario/perfil" class="acceso">
                <div class="icono">👤</div>
                <strong>Mi Perfil</strong>
                <p>Editar mis datos</p>
            </a>
        </div>

        <h3>📖 Mis Préstamos Activos</h3>
        <c:choose>
            <c:when test="${empty prestamos}">
                <div class="empty">
                    📭 No tienes préstamos activos.
                    <br><br>
                    <a href="<%=request.getContextPath()%>/usuario/catalogo">Ver catálogo</a>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Libro</th>
                            <th>Fecha Préstamo</th>
                            <th>Fecha Límite</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="prestamo" items="${prestamos}" varStatus="loop">
                            <c:if test="${prestamo.estado == 'ACTIVO' || prestamo.estado == 'ATRASADO'}">
                                <tr>
                                    <td>${loop.count}</td>
                                    <td>${prestamo.tituloLibro}</td>
                                    <td>${prestamo.fechaPrestamo}</td>
                                    <td>${prestamo.fechaLimite}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${prestamo.estado == 'ACTIVO'}">
                                                <span class="badge badge-warning">Activo</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Atrasado</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>