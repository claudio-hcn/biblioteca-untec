package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.LibroDAO;
import com.untec.biblioteca.dao.PrestamoDAO;
import com.untec.biblioteca.dao.UsuarioDAO;
import com.untec.biblioteca.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (!"ADMIN".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/usuario/dashboard");
            return;
        }

        try {
            PrestamoDAO prestamoDAO = new PrestamoDAO();
            prestamoDAO.actualizarAtrasados(); 
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            LibroDAO libroDAO = new LibroDAO();

            request.setAttribute("totalActivos", prestamoDAO.contarActivos());
            request.setAttribute("totalAtrasados", prestamoDAO.contarAtrasados());
            request.setAttribute("totalUsuarios", usuarioDAO.contarUsuarios());
            request.setAttribute("totalLibros", libroDAO.contarLibros());

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }
}