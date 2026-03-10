package com.untec.biblioteca.servlet;

import com.untec.biblioteca.dao.LibroDAO;
import com.untec.biblioteca.dao.PrestamoDAO;
import com.untec.biblioteca.model.Libro;
import com.untec.biblioteca.model.Prestamo;
import com.untec.biblioteca.model.Usuario;
import com.untec.biblioteca.util.Validador;
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

@WebServlet("/usuario/prestamos")
public class PrestamoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        try {
            PrestamoDAO prestamoDAO = new PrestamoDAO();
            LibroDAO libroDAO = new LibroDAO();

            switch (accion) {

                case "listar":
                    List<Prestamo> prestamos = prestamoDAO.listarPorUsuario(usuario.getIdUsuario());
                    request.setAttribute("prestamos", prestamos);
                    request.getRequestDispatcher("/views/usuario/prestamos.jsp").forward(request, response);
                    break;

                case "solicitar":
                    int idLibro = Integer.parseInt(request.getParameter("id"));
                    Libro libro = libroDAO.buscarPorId(idLibro);

                    if (libro == null || !libro.isDisponible()) {
                        request.setAttribute("error", "El libro no está disponible");
                        List<Prestamo> lista = prestamoDAO.listarPorUsuario(usuario.getIdUsuario());
                        request.setAttribute("prestamos", lista);
                        request.getRequestDispatcher("/views/usuario/prestamos.jsp").forward(request, response);
                        return;
                    }

                    // Calcular fechas
                    LocalDate hoy = LocalDate.now();
                    LocalDate fechaLimite = Validador.calcularFechaLimite(hoy, 7);

                    // Crear préstamo
                    Prestamo prestamo = new Prestamo(
                        0,
                        usuario.getIdUsuario(),
                        idLibro,
                        hoy.toString(),
                        fechaLimite.toString(),
                        null,
                        "ACTIVO"
                        
                    );
                    prestamoDAO.insertar(prestamo);

                    // Marcar libro como no disponible
                    libro.setDisponible(false);
                    libroDAO.actualizar(libro);

                    response.sendRedirect(request.getContextPath() + "/usuario/prestamos?exito=solicitado");
                    break;

                case "devolver":
                    int idPrestamo = Integer.parseInt(request.getParameter("id"));
                    Prestamo prestamoDevolver = prestamoDAO.buscarPorId(idPrestamo);

                    // Devolver libro
                    prestamoDAO.devolver(idPrestamo, LocalDate.now().toString());

                    // Marcar libro como disponible
                    Libro libroDevolver = libroDAO.buscarPorId(prestamoDevolver.getIdLibro());
                    libroDevolver.setDisponible(true);
                    libroDAO.actualizar(libroDevolver);

                    response.sendRedirect(request.getContextPath() + "/usuario/prestamos?exito=devuelto");
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/usuario/prestamos");
            }

        } catch (SQLException e) {
            throw new ServletException("Error en base de datos", e);
        }
    }
}