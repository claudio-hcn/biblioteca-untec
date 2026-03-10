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

@WebServlet("/admin/historial")
public class AdminPrestamoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verificar sesión y rol ADMIN
         // Verificar sesión y rol
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
        

        // 2. Traer todos los préstamos con PrestamoDAO
        PrestamoDAO prestamoDAO = new PrestamoDAO();
        List<Prestamo> prestamos;

        try {
            prestamos = prestamoDAO.listarTodos();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        // 3. Guardar en request y mandar al JSP
        request.setAttribute("prestamos", prestamos);
        request.getRequestDispatcher("/views/admin/historial.jsp").forward(request, response);

    }
}