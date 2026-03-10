package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.LibroDAO;
import com.untec.biblioteca.model.Libro;
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

@WebServlet("/admin/libros")
public class LibroServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        try {
            LibroDAO libroDAO = new LibroDAO();

            switch (accion) {
                case "listar":
                    List<Libro> libros = libroDAO.listarTodos();
                    request.setAttribute("libros", libros);
                    request.getRequestDispatcher("/views/admin/libros.jsp").forward(request, response);
                    break;

                case "nuevo":
                    request.getRequestDispatcher("/views/admin/libro-form.jsp").forward(request, response);
                    break;

                case "editar":
                    int idEditar = Integer.parseInt(request.getParameter("id"));
                    Libro libro = libroDAO.buscarPorId(idEditar);
                    request.setAttribute("libro", libro);
                    request.getRequestDispatcher("/views/admin/libro-form.jsp").forward(request, response);
                    break;

                case "eliminar":
                    int idEliminar = Integer.parseInt(request.getParameter("id"));
                    libroDAO.eliminar(idEliminar);
                    response.sendRedirect(request.getContextPath() + "/admin/libros");
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/admin/libros");
            }

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("idLibro");
        String isbn = request.getParameter("isbn");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        int anio = Integer.parseInt(request.getParameter("anioPublicacion"));
        String editorial = request.getParameter("editorial");
        String categoria = request.getParameter("categoria");
        boolean disponible = request.getParameter("disponible") != null;

        Libro libro = new Libro(0, isbn, titulo, autor, anio, editorial, categoria, disponible);

        try {
            LibroDAO libroDAO = new LibroDAO();

            if (idParam == null || idParam.isEmpty()) {
                // Insertar nuevo
                libroDAO.insertar(libro);
            } else {
                // Actualizar existente
                libro.setIdLibro(Integer.parseInt(idParam));
                libroDAO.actualizar(libro);
            }

            response.sendRedirect(request.getContextPath() + "/admin/libros");

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }
    }
}