package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.UsuarioDAO;
import com.untec.biblioteca.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            Usuario usuario = usuarioDAO.buscarPorEmail(email);

            if (usuario != null && BCrypt.checkpw(password, usuario.getPassword())) {

                if (!usuario.isActivo()) {
                    request.setAttribute("error", "Tu cuenta ha sido bloqueada. Contacta al administrador.");
                    request.getRequestDispatcher("/views/login.jsp").forward(request, response);
                    return;
                }
                // Login correcto → crear sesión
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogueado", usuario);

                // Redirigir según rol
                if ("ADMIN".equals(usuario.getRol())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/usuario/dashboard");
                }

            } else {
                // Login incorrecto → volver con error
                request.setAttribute("error", "Email o contraseña incorrectos");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }
    }
}