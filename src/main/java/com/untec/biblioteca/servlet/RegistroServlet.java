package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.UsuarioDAO;
import com.untec.biblioteca.model.Usuario;
import com.untec.biblioteca.util.Validador;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String rut = request.getParameter("rut");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String carrera = request.getParameter("carrera");
        String fechaNacimiento = request.getParameter("fechaNacimiento");

        // Validaciones
        if (!Validador.validarNombre(nombre)) {
            request.setAttribute("error", "El nombre solo puede contener letras y espacios");
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
            return;
        }

        if (!Validador.validarRut(rut)) {
            request.setAttribute("error", "El RUT ingresado no es válido");
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
            return;
        }

        if (!Validador.validarEmail(email)) {
            request.setAttribute("error", "El email ingresado no es válido");
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
            return;
        }

        if (!Validador.validarPassword(password)) {
            request.setAttribute("error", "La contraseña debe tener mínimo 8 caracteres, una mayúscula, un número y un carácter especial");
            request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
            return;
        }

        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO();

            // Verificar si el email ya existe
            if (usuarioDAO.buscarPorEmail(email) != null) {
                request.setAttribute("error", "Ya existe una cuenta con ese email");
                request.getRequestDispatcher("/views/registro.jsp").forward(request, response);
                return;
            }

            // Encriptar password
            String hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Crear usuario
            Usuario usuario = new Usuario(0, nombre, rut, email, hashPassword, carrera, fechaNacimiento, "USUARIO", true);
            usuarioDAO.insertar(usuario);

            // Redirigir al login con mensaje de éxito
            response.sendRedirect(request.getContextPath() + "/login?registro=exitoso");

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }
    }
}