package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.LibroDAO;
import com.untec.biblioteca.model.Libro;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/usuario/catalogo")
public class CatalogoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Traer todos los libros
        try {
            LibroDAO libroDAO = new LibroDAO();
            List<Libro> libros = libroDAO.listarTodos();
            request.setAttribute("libros", libros);
            request.getRequestDispatcher("/views/usuario/catalogo.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }
    }
}
