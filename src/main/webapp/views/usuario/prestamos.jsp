<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Préstamos - Biblioteca UNTEC</title>
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
        .badge-success  { background: #d4edda; color: #155724; }
        .badge-warning  { background: #fff3cd; color: #856404; }
        .badge-danger   { background: #f8d7da; color: #721c24; }
        .btn {
            padding: 6px 14px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
        }
        .btn-success { background: #28a745; color: white; }
        .btn:hover { opacity: 0.85; }
        .exito {
            background: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 16px;
            text-align: center;
        }
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
            <a href="<%=request.getContextPath()%>/usuario/dashboard">Dashboard</a>
            <a href="<%=request.getContextPath()%>/usuario/catalogo">Catálogo</a>
            <a href="<%=request.getContextPath()%>/logout">Cerrar sesión</a>
        </div>
    </div>

    <div class="container">
        <h2>📋 Mis Préstamos</h2>

        <c:if test="${param.exito == 'solicitado'}">
            <div class="exito">✅ Préstamo solicitado exitosamente</div>
        </c:if>
        <c:if test="${param.exito == 'devuelto'}">
            <div class="exito">✅ Libro devuelto exitosamente</div>
        </c:if>

        <c:choose>
            <c:when test="${empty prestamos}">
                <div class="empty">
                    <p>📭 No tienes préstamos activos</p>
                    <br>
                    <a href="<%=request.getContextPath()%>/usuario/catalogo">Ver catálogo de libros</a>
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
                            <th>Fecha Devolución</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="prestamo" items="${prestamos}" varStatus="loop">
                            <tr>
                                <td>${loop.count}</td>
                                <td>${prestamo.tituloLibro}</td>
                                <td>${prestamo.fechaPrestamo}</td>
                                <td>${prestamo.fechaLimite}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty prestamo.fechaDevolucion}">-</c:when>
                                        <c:otherwise>${prestamo.fechaDevolucion}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${prestamo.estado == 'ACTIVO'}">
                                            <span class="badge badge-warning">Activo</span>
                                        </c:when>
                                        <c:when test="${prestamo.estado == 'DEVUELTO'}">
                                            <span class="badge badge-success">Devuelto</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-danger">Atrasado</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                              
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>