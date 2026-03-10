package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.LibroDAO;
import com.untec.biblioteca.dao.PrestamoDAO;
import com.untec.biblioteca.model.Libro;
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
import java.time.LocalDate;
import java.util.List;

@WebServlet("/admin/historial")
public class AdminPrestamoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verificar sesión y rol ADMIN
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

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        PrestamoDAO prestamoDAO = new PrestamoDAO();

        try {
            prestamoDAO.actualizarAtrasados();

            switch (accion) {

                case "listar":
                    List<Prestamo> prestamos = prestamoDAO.listarTodos();
                    request.setAttribute("prestamos", prestamos);
                    request.getRequestDispatcher("/views/admin/historial.jsp").forward(request, response);
                    break;

                case "devolver":
                    int idPrestamo = Integer.parseInt(request.getParameter("id"));
                    Prestamo prestamo = prestamoDAO.buscarPorId(idPrestamo);
                    prestamoDAO.devolver(idPrestamo, LocalDate.now().toString());

                    // Marcar libro como disponible
                    LibroDAO libroDAO = new LibroDAO();
                    Libro libro = libroDAO.buscarPorId(prestamo.getIdLibro());
                    libro.setDisponible(true);
                    libroDAO.actualizar(libro);

                    response.sendRedirect(request.getContextPath() + "/admin/historial");
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/admin/historial");
            }

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }
    }
}