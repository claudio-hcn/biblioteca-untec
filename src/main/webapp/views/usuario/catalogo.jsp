<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo - Biblioteca UNTEC</title>
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
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 16px;
        }
        .card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .card h3 { font-size: 16px; margin-bottom: 8px; color: #333; }
        .card p { font-size: 13px; color: #666; margin-bottom: 4px; }
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            margin: 8px 0;
        }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-danger  { background: #f8d7da; color: #721c24; }
        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            text-align: center;
            text-decoration: none;
            margin-top: 12px;
        }
        .btn-primary { background: #4a90e2; color: white; }
        .btn-disabled { background: #ccc; color: #666; cursor: not-allowed; }
        .btn:hover:not(.btn-disabled) { opacity: 0.85; }
        .error {
            background: #ffe0e0;
            color: #cc0000;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 16px;
            text-align: center;
        }
        .exito {
            background: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 16px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <span>📚 Biblioteca UNTEC</span>
        <div>
            <a href="<%=request.getContextPath()%>/usuario/dashboard">Dashboard</a>
            <a href="<%=request.getContextPath()%>/usuario/prestamos">Mis Préstamos</a>
            <a href="<%=request.getContextPath()%>/logout">Cerrar sesión</a>
        </div>
    </div>

    <div class="container">
        <h2>📖 Catálogo de Libros</h2>
        <input type="text" id="buscador" placeholder="🔍 Buscar por título o autor..." 
       style="width:100%; padding:10px; border:1px solid #ddd; border-radius:4px; 
              font-size:14px; margin-bottom:20px;" 
       onkeyup="filtrarLibros()"/>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:if test="${param.exito == 'solicitado'}">
            <div class="exito">✅ Préstamo solicitado exitosamente</div>
        </c:if>

        <div class="grid">
            <c:forEach var="libro" items="${libros}">
                <div class="card">
                    <h3>${libro.titulo}</h3>
                    <p>✍️ ${libro.autor}</p>
                    <p>🏢 ${libro.editorial}</p>
                    <p>📅 ${libro.anioPublicacion}</p>
                    <p>🏷️ ${libro.categoria}</p>
                    <c:choose>
                        <c:when test="${libro.disponible}">
                            <span class="badge badge-success">Disponible</span>
                            <a href="<%=request.getContextPath()%>/usuario/prestamos?accion=solicitar&id=${libro.idLibro}"
                               class="btn btn-primary"
                               onclick="return confirm('¿Solicitar préstamo de este libro?')">
                                Solicitar préstamo
                            </a>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-danger">No disponible</span>
                            <span class="btn btn-disabled">No disponible</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
    </div>
<script>
    function filtrarLibros() {
        let busqueda = document.getElementById("buscador").value.toLowerCase();
        let tarjetas = document.querySelectorAll(".card");

        tarjetas.forEach(function(tarjeta) {
            let texto = tarjeta.innerText.toLowerCase();
            if (texto.includes(busqueda)) {
                tarjeta.style.display = "block";
            } else {
                tarjeta.style.display = "none";
            }
        });
    }
</script>
</body>
</html>