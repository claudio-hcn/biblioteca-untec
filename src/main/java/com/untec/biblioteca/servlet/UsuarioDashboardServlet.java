package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.PrestamoDAO;
import com.untec.biblioteca.model.Prestamo;
import com.untec.biblioteca.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/usuario/dashboard")
public class UsuarioDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (!"USUARIO".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            PrestamoDAO prestamoDAO = new PrestamoDAO();
            List<Prestamo> prestamos = prestamoDAO.listarPorUsuario(usuario.getIdUsuario());
            request.setAttribute("prestamos", prestamos);

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }

        request.getRequestDispatcher("/views/usuario/dashboard.jsp").forward(request, response);
    }
}