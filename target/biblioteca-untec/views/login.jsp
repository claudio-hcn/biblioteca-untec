<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page isELIgnored="false" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="es">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Login - Biblioteca UNTEC</title>
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: Arial, sans-serif;
                        background-color: #f0f2f5;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        height: 100vh;
                    }

                    .login-container {
                        background: white;
                        padding: 40px;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        width: 100%;
                        max-width: 400px;
                    }

                    h2 {
                        text-align: center;
                        margin-bottom: 24px;
                        color: #333;
                    }

                    .form-group {
                        margin-bottom: 16px;
                    }

                    label {
                        display: block;
                        margin-bottom: 6px;
                        color: #555;
                        font-size: 14px;
                    }

                    input {
                        width: 100%;
                        padding: 10px;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        font-size: 14px;
                    }

                    input:focus {
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

                    button:hover {
                        background-color: #357abd;
                    }

                    .error {
                        background-color: #ffe0e0;
                        color: #cc0000;
                        padding: 10px;
                        border-radius: 4px;
                        margin-bottom: 16px;
                        font-size: 14px;
                        text-align: center;
                    }

                    .register-link {
                        text-align: center;
                        margin-top: 16px;
                        font-size: 14px;
                        color: #555;
                    }

                    .register-link a {
                        color: #4a90e2;
                        text-decoration: none;
                    }

                    .exito {
                        background-color: #d4edda;
                        color: #155724;
                        padding: 10px;
                        border-radius: 4px;
                        margin-bottom: 16px;
                        font-size: 14px;
                        text-align: center;
                    }
                </style>
            </head>

            <body>
                <div class="login-container">
                    <h2>📚 Biblioteca UNTEC</h2>

                    <%-- Mostrar error si existe --%>
                        <c:if test="${not empty error}">
                            <div class="error">${error}</div>
                        </c:if>
                        <%-- Mostrar éxito si viene de registro --%>
                            <c:if test="${param.registro == 'exitoso'}">
                                <div class="exito">✅ Registro exitoso, ya puedes iniciar sesión</div>
                            </c:if>

                            <form action="<%=request.getContextPath()%>/login" method="post">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" id="email" name="email" placeholder="tucorreo@untec.cl"
                                        required />
                                </div>
                                <div class="form-group">
                                    <label for="password">Contraseña</label>
                                    <input type="password" id="password" name="password" placeholder="••••••••"
                                        required />
                                </div>
                                <button type="submit">Ingresar</button>
                            </form>

                            <div class="register-link">
                                ¿No tienes cuenta? <a href="<%=request.getContextPath()%>/registro">Regístrate aquí</a>
                            </div>
                </div>
            </body>

            </html>