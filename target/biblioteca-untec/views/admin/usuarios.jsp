<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios - UNTEC</title>
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
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 300px;
        }
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
        .badge-success { background: #d4edda; color: #155724; }
        .badge-danger  { background: #f8d7da; color: #721c24; }
        .acciones { display: flex; gap: 8px; }
        .btn {
            padding: 6px 14px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
        }
        .btn-warning  { background: #f5a623; color: white; }
        .btn-success  { background: #28a745; color: white; }
        .btn-danger   { background: #e74c3c; color: white; }
        .btn:hover { opacity: 0.85; }
    </style>
</head>
<body>
    <div class="navbar">
        <span>📚 Biblioteca UNTEC - Admin</span>
        <div>
            <a href="<%=request.getContextPath()%>/admin/dashboard">Dashboard</a>
            <a href="<%=request.getContextPath()%>/admin/libros">Libros</a>
            <a href="<%=request.getContextPath()%>/admin/historial">Historial</a>
            <a href="<%=request.getContextPath()%>/logout">Cerrar sesión</a>
        </div>
    </div>

    <div class="container">
        <div class="header">
            <h2>👤 Gestión de Usuarios</h2>
            <input type="text" id="buscador" placeholder="🔍 Buscar por nombre o carrera..."
                   onkeyup="filtrar()"/>
        </div>

        <table id="tablaUsuarios">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>RUT</th>
                    <th>Email</th>
                    <th>Carrera</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${usuarios}" varStatus="loop">
                    <tr>
                        <td>${loop.count}</td>
                        <td>${u.nombre}</td>
                        <td>${u.rut}</td>
                        <td>${u.email}</td>
                        <td>${u.carrera}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.activo}">
                                    <span class="badge badge-success">Activo</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger">Bloqueado</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="acciones">
                            <c:choose>
                                <c:when test="${u.activo}">
                                    <a href="<%=request.getContextPath()%>/admin/usuarios?accion=bloquear&id=${u.idUsuario}"
                                       class="btn btn-warning"
                                       onclick="return confirm('¿Bloquear a ${u.nombre}?')">
                                        Bloquear
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/admin/usuarios?accion=desbloquear&id=${u.idUsuario}"
                                       class="btn btn-success"
                                       onclick="return confirm('¿Desbloquear a ${u.nombre}?')">
                                        Desbloquear
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            <a href="<%=request.getContextPath()%>/admin/usuarios?accion=eliminar&id=${u.idUsuario}"
                               class="btn btn-danger"
                               onclick="return confirm('¿Eliminar a ${u.nombre}? Esta acción no se puede deshacer.')">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function filtrar() {
            let busqueda = document.getElementById("buscador").value.toLowerCase();
            let filas = document.querySelectorAll("#tablaUsuarios tbody tr");
            filas.forEach(function(fila) {
                let texto = fila.innerText.toLowerCase();
                fila.style.display = texto.includes(busqueda) ? "" : "none";
            });
        }
    </script>
</body>
</html>