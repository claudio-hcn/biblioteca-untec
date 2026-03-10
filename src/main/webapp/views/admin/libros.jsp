<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Libros - UNTEC</title>
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
        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }
        .btn-primary { background: #4a90e2; color: white; }
        .btn-warning { background: #f5a623; color: white; }
        .btn-danger  { background: #e74c3c; color: white; }
        .acciones { display: flex; gap: 8px; }
        .btn:hover { opacity: 0.85; }
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
    </style>
</head>
<body>
    <div class="navbar">
        <span>📚 Biblioteca UNTEC - Admin</span>
        <div>
            <a href="<%=request.getContextPath()%>/admin/dashboard">Dashboard</a>
            <a href="<%=request.getContextPath()%>/logout">Cerrar sesión</a>
        </div>
    </div>

    <div class="container">
        <div class="header">
            <h2>Gestión de Libros</h2>
            <a href="<%=request.getContextPath()%>/admin/libros?accion=nuevo" class="btn btn-primary">
                + Agregar Libro
            </a>
        </div>
<input type="text" id="buscador" placeholder="🔍 Buscar por título o autor..." 
       style="width:100%; padding:10px; border:1px solid #ddd; border-radius:4px; 
              font-size:14px; margin-bottom:20px;" 
       onkeyup="filtrarLibros()"/>
        <table id="tablaLibros">
            <thead>
                <tr>
                    <th>#</th>
                    <th>ISBN</th>
                    <th>Título</th>
                    <th>Autor</th>
                    <th>Año</th>
                    <th>Categoría</th>
                    <th>Disponible</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="libro" items="${libros}" varStatus="loop">
                    <tr>
                       <td>${loop.count}</td>
                        <td>${libro.isbn}</td>
                        <td>${libro.titulo}</td>
                        <td>${libro.autor}</td>
                        <td>${libro.anioPublicacion}</td>
                        <td>${libro.categoria}</td>
                        <td>
                            <c:choose>
                                <c:when test="${libro.disponible}">
                                    <span class="badge badge-success">Disponible</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger">Prestado</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="acciones">
                            <a href="<%=request.getContextPath()%>/admin/libros?accion=editar&id=${libro.idLibro}" 
                               class="btn btn-warning">Editar</a>
                            <a href="<%=request.getContextPath()%>/admin/libros?accion=eliminar&id=${libro.idLibro}"
                               class="btn btn-danger"
                               onclick="return confirm('¿Eliminar este libro?')">Eliminar</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
<script>
     function filtrarLibros() {
            let busqueda = document.getElementById("buscador").value.toLowerCase();
            let filas = document.querySelectorAll("#tablaLibros tbody tr");
            filas.forEach(function(fila) {
                let texto = fila.innerText.toLowerCase();
                fila.style.display = texto.includes(busqueda) ? "" : "none";
            });
        }
</script>
</body>
</html>