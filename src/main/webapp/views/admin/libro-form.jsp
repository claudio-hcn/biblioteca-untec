<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${not empty libro}">Editar Libro</c:when>
            <c:otherwise>Nuevo Libro</c:otherwise>
        </c:choose>
        - UNTEC
    </title>
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
        .container {
            padding: 24px;
            max-width: 600px;
            margin: 0 auto;
        }
        .card {
            background: white;
            padding: 32px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 { margin-bottom: 24px; color: #333; }
        .form-group { margin-bottom: 16px; }
        label {
            display: block;
            margin-bottom: 6px;
            color: #555;
            font-size: 14px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #4a90e2;
        }
        .form-check {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-check input { width: auto; }
        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }
        .btn {
            padding: 10px 24px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
        }
        .btn-primary { background: #4a90e2; color: white; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn:hover { opacity: 0.85; }
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
        <div class="card">
            <h2>
                <c:choose>
                    <c:when test="${not empty libro}">✏️ Editar Libro</c:when>
                    <c:otherwise>➕ Nuevo Libro</c:otherwise>
                </c:choose>
            </h2>

            <form action="<%=request.getContextPath()%>/admin/libros" method="post">

                <%-- Campo oculto para saber si es edición --%>
                <input type="hidden" name="idLibro" value="${libro.idLibro}" />

                <div class="form-group">
                    <label>ISBN</label>
                    <input type="text" name="isbn" value="${libro.isbn}" 
                           placeholder="978-xx-xxx-xxxx-x" required />
                </div>
                <div class="form-group">
                    <label>Título</label>
                    <input type="text" name="titulo" value="${libro.titulo}" 
                           placeholder="Título del libro" required />
                </div>
                <div class="form-group">
                    <label>Autor</label>
                    <input type="text" name="autor" value="${libro.autor}" 
                           placeholder="Nombre del autor" required />
                </div>
                <div class="form-group">
                    <label>Año de Publicación</label>
                    <input type="number" name="anioPublicacion" value="${libro.anioPublicacion}" 
                           placeholder="2024" min="1900" max="2100" required />
                </div>
                <div class="form-group">
                    <label>Editorial</label>
                    <input type="text" name="editorial" value="${libro.editorial}" 
                           placeholder="Editorial" />
                </div>
                <div class="form-group">
                    <label>Categoría</label>
                    <select name="categoria">
                        <c:forEach var="cat" items="${['Matematicas','Programacion','Base de Datos','Redes','Ingenieria Software','Sistemas Operativos','Inteligencia Artificial','Fisica','Quimica','Biologia','Administracion','Marketing','Contabilidad','Economia','Filosofia','Historia','Psicologia','Sociologia','Literatura']}">
                            <option value="${cat}" ${libro.categoria == cat ? 'selected' : ''}>${cat}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <div class="form-check">
                        <input type="checkbox" name="disponible" id="disponible"
                               ${libro.disponible || empty libro ? 'checked' : ''} />
                        <label for="disponible">Disponible</label>
                    </div>
                </div>

                <div class="buttons">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty libro}">Guardar Cambios</c:when>
                            <c:otherwise>Agregar Libro</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="<%=request.getContextPath()%>/admin/libros" class="btn btn-secondary">
                        Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>