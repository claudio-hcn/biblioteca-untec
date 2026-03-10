<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page isELIgnored="false" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="es">

            <head>
                <meta charset="UTF-8">
                <title>Historial de Préstamos - UNTEC</title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: Arial, sans-serif;
                        background: #f0f2f5;
                    }

                    .navbar {
                        background: #4a90e2;
                        color: white;
                        padding: 16px 24px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .navbar a {
                        color: white;
                        text-decoration: none;
                        margin-left: 16px;
                    }

                    .container {
                        padding: 24px;
                        max-width: 1200px;
                        margin: 0 auto;
                    }

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
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        border-collapse: collapse;
                    }

                    th {
                        background: #4a90e2;
                        color: white;
                        padding: 12px 16px;
                        text-align: left;
                        font-size: 14px;
                    }

                    td {
                        padding: 12px 16px;
                        border-bottom: 1px solid #eee;
                        font-size: 14px;
                    }

                    tr:last-child td {
                        border-bottom: none;
                    }

                    tr:hover td {
                        background: #f9f9f9;
                    }

                    .badge {
                        padding: 4px 10px;
                        border-radius: 12px;
                        font-size: 12px;
                        font-weight: bold;
                    }

                    .badge-success {
                        background: #d4edda;
                        color: #155724;
                    }

                    .badge-warning {
                        background: #fff3cd;
                        color: #856404;
                    }

                    .badge-danger {
                        background: #f8d7da;
                        color: #721c24;
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
                    <span>📚 Biblioteca UNTEC - Admin</span>
                    <div>
                        <a href="<%=request.getContextPath()%>/admin/dashboard">Dashboard</a>
                        <a href="<%=request.getContextPath()%>/admin/libros">Libros</a>
                        <a href="<%=request.getContextPath()%>/logout">Cerrar sesión</a>
                    </div>
                </div>

                <div class="container">
                    <div class="header">
                        <h2>📋 Historial de Préstamos</h2>
                        <input type="text" id="buscador" placeholder="🔍 Buscar por usuario o libro..."
                            onkeyup="filtrar()" />
                    </div>

                    <c:choose>
                        <c:when test="${empty prestamos}">
                            <div class="empty">📭 No hay préstamos registrados</div>
                        </c:when>
                        <c:otherwise>
                            <table id="tablaPrestamos">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Usuario</th>
                                        <th>Libro</th>
                                        <th>Fecha Préstamo</th>
                                        <th>Fecha Límite</th>
                                        <th>Fecha Devolución</th>
                                        <th>Estado</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="prestamo" items="${prestamos}" varStatus="loop">
                                        <tr>
                                            <td>${loop.count}</td>
                                            <td>${prestamo.nombreUsuario}</td>
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
                                            <td>
                                                <c:if
                                                    test="${prestamo.estado == 'ACTIVO' || prestamo.estado == 'ATRASADO'}">
                                                    <a href="<%=request.getContextPath()%>/admin/historial?accion=devolver&id=${prestamo.idPrestamo}"
                                                        class="btn btn-success"
                                                        onclick="return confirm('¿Confirmar devolución del libro?')">
                                                        Registrar Devolución
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>

                <script>
                    function filtrar() {
                        let busqueda = document.getElementById("buscador").value.toLowerCase();
                        let filas = document.querySelectorAll("#tablaPrestamos tbody tr");
                        filas.forEach(function (fila) {
                            let texto = fila.innerText.toLowerCase();
                            fila.style.display = texto.includes(busqueda) ? "" : "none";
                        });
                    }
                </script>
            </body>

            </html>