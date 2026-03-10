package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.UsuarioDAO;
import com.untec.biblioteca.model.Usuario;
import com.untec.biblioteca.util.Validador;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/usuario/perfil")
public class PerfilServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/views/usuario/perfil.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Usuario usuarioActual = (Usuario) session.getAttribute("usuarioLogueado");

        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String carrera = request.getParameter("carrera");
        String passwordNueva = request.getParameter("password");

        // Validaciones
        if (!Validador.validarNombre(nombre)) {
            request.setAttribute("error", "El nombre solo puede contener letras y espacios");
            request.getRequestDispatcher("/views/usuario/perfil.jsp").forward(request, response);
            return;
        }

        if (!Validador.validarEmail(email)) {
            request.setAttribute("error", "El email ingresado no es válido");
            request.getRequestDispatcher("/views/usuario/perfil.jsp").forward(request, response);
            return;
        }

        // Si ingresó nueva password, validarla
        if (passwordNueva != null && !passwordNueva.isEmpty()) {
            if (!Validador.validarPassword(passwordNueva)) {
                request.setAttribute("error", "La contraseña debe tener mínimo 8 caracteres, una mayúscula, un número y un carácter especial");
                request.getRequestDispatcher("/views/usuario/perfil.jsp").forward(request, response);
                return;
            }
            usuarioActual.setPassword(BCrypt.hashpw(passwordNueva, BCrypt.gensalt()));
        }

        try {
            usuarioActual.setNombre(nombre);
            usuarioActual.setEmail(email);
            usuarioActual.setCarrera(carrera);

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioDAO.actualizar(usuarioActual);

            // Actualizar sesión con los nuevos datos
            session.setAttribute("usuarioLogueado", usuarioActual);

            request.setAttribute("exito", "Perfil actualizado correctamente");
            request.getRequestDispatcher("/views/usuario/perfil.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }
    }
}