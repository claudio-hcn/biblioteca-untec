<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil - Biblioteca UNTEC</title>
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
        input:disabled {
            background: #f5f5f5;
            color: #888;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 8px;
        }
        button:hover { background-color: #357abd; }
        .error {
            background: #ffe0e0;
            color: #cc0000;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 16px;
            font-size: 14px;
            text-align: center;
        }
        .exito {
            background: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 16px;
            font-size: 14px;
            text-align: center;
        }
        .hint {
            font-size: 12px;
            color: #888;
            margin-top: 4px;
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
        <div class="card">
            <h2>👤 Mi Perfil</h2>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            <c:if test="${not empty exito}">
                <div class="exito">✅ ${exito}</div>
            </c:if>

            <form action="<%=request.getContextPath()%>/usuario/perfil" method="post">

                <div class="form-group">
                    <label>RUT</label>
                    <input type="text" value="${sessionScope.usuarioLogueado.rut}" disabled />
                    <p class="hint">El RUT no puede modificarse</p>
                </div>
                <div class="form-group">
                    <label>Nombre completo</label>
                    <input type="text" name="nombre" 
                           value="${sessionScope.usuarioLogueado.nombre}" required />
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" 
                           value="${sessionScope.usuarioLogueado.email}" required />
                </div>
                <div class="form-group">
                    <label>Carrera</label>
                    <select name="carrera">
                        <option value="Ingeniería Informática" ${sessionScope.usuarioLogueado.carrera == 'Ingeniería Informática' ? 'selected' : ''}>Ingeniería Informática</option>
                        <option value="Ingeniería Civil" ${sessionScope.usuarioLogueado.carrera == 'Ingeniería Civil' ? 'selected' : ''}>Ingeniería Civil</option>
                        <option value="Administración" ${sessionScope.usuarioLogueado.carrera == 'Administración' ? 'selected' : ''}>Administración</option>
                        <option value="Contabilidad" ${sessionScope.usuarioLogueado.carrera == 'Contabilidad' ? 'selected' : ''}>Contabilidad</option>
                        <option value="Psicología" ${sessionScope.usuarioLogueado.carrera == 'Psicología' ? 'selected' : ''}>Psicología</option>
                        <option value="Derecho" ${sessionScope.usuarioLogueado.carrera == 'Derecho' ? 'selected' : ''}>Derecho</option>
                        <option value="Medicina" ${sessionScope.usuarioLogueado.carrera == 'Medicina' ? 'selected' : ''}>Medicina</option>
                        <option value="Marketing" ${sessionScope.usuarioLogueado.carrera == 'Marketing' ? 'selected' : ''}>Marketing</option>
                        <option value="Otra" ${sessionScope.usuarioLogueado.carrera == 'Otra' ? 'selected' : ''}>Otra</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Nueva Contraseña</label>
                    <input type="password" name="password" 
                           placeholder="Dejar vacío para mantener la actual" />
                    <p class="hint">Mínimo 8 caracteres, una mayúscula, un número y un carácter especial</p>
                </div>

                <button type="submit">Guardar Cambios</button>
            </form>
        </div>
    </div>
</body>
</html>