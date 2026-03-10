<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Biblioteca UNTEC</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 24px;
        }
        .registro-container {
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
        }
        h2 { text-align: center; margin-bottom: 24px; color: #333; }
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
            background-color: #ffe0e0;
            color: #cc0000;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 16px;
            font-size: 14px;
            text-align: center;
        }
        .login-link {
            text-align: center;
            margin-top: 16px;
            font-size: 14px;
            color: #555;
        }
        .login-link a { color: #4a90e2; text-decoration: none; }
        .hint {
            font-size: 12px;
            color: #888;
            margin-top: 4px;
        }
    </style>
</head>
<body>
    <div class="registro-container">
        <h2>📚 Registro - Biblioteca UNTEC</h2>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form action="<%=request.getContextPath()%>/registro" method="post">
            <div class="form-group">
                <label>Nombre completo</label>
                <input type="text" name="nombre" value="${param.nombre}"
                       placeholder="Juan Pérez" required />
            </div>
            <div class="form-group">
                <label>RUT</label>
                <input type="text" name="rut" value="${param.rut}"
                       placeholder="12345678-9" required />
                <p class="hint">Formato: 12345678-9</p>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="${param.email}"
                       placeholder="tucorreo@untec.cl" required />
            </div>
            <div class="form-group">
                <label>Contraseña</label>
                <input type="password" name="password" placeholder="••••••••" required />
                <p class="hint">Mínimo 8 caracteres, una mayúscula, un número y un carácter especial</p>
            </div>
            <div class="form-group">
                <label>Carrera</label>
                <select name="carrera">
                    <option value="">Selecciona tu carrera</option>
                    <option value="Ingeniería Informática">Ingeniería Informática</option>
                    <option value="Ingeniería Civil">Ingeniería Civil</option>
                    <option value="Administración">Administración</option>
                    <option value="Contabilidad">Contabilidad</option>
                    <option value="Psicología">Psicología</option>
                    <option value="Derecho">Derecho</option>
                    <option value="Medicina">Medicina</option>
                    <option value="Otra">Otra</option>
                </select>
            </div>
            <div class="form-group">
                <label>Fecha de nacimiento</label>
                <input type="date" name="fechaNacimiento" value="${param.fechaNacimiento}" required />
            </div>

            <button type="submit">Registrarse</button>
        </form>

        <div class="login-link">
            ¿Ya tienes cuenta? <a href="<%=request.getContextPath()%>/login">Inicia sesión aquí</a>
        </div>
    </div>
</body>
</html>