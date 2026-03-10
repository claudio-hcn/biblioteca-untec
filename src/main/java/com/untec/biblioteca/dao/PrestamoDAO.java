package com.untec.biblioteca.dao;

import com.untec.biblioteca.model.Prestamo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO {
    // Listar todos los préstamos
    public List<Prestamo> listarTodos() throws SQLException {
        List<Prestamo> prestamos = new ArrayList<>();
        String sql = "SELECT p.*, u.nombre AS nombre_usuario, l.titulo AS titulo_libro\n" + //
                        "FROM prestamos p\n" + //
                        "JOIN usuarios u ON p.id_usuario = u.id_usuario\n" + //
                        "JOIN libros l ON p.id_libro = l.id_libro";
                        

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Prestamo prestamo = new Prestamo(
                    rs.getInt("id_prestamo"),
                    rs.getInt("id_usuario"),
                    rs.getInt("id_libro"),
                    rs.getString("fecha_prestamo"),
                    rs.getString("fecha_limite"),
                    rs.getString("fecha_devolucion"),
                    rs.getString("estado"),
                    rs.getString("titulo_libro"),
                    rs.getString("nombre_usuario")
                );
                prestamos.add(prestamo);
            }
        }
        return prestamos;
    }

    // Buscar préstamo por ID
    public Prestamo buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM prestamos WHERE id_prestamo = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Prestamo(
                        rs.getInt("id_prestamo"),
                        rs.getInt("id_usuario"),
                        rs.getInt("id_libro"),
                        rs.getString("fecha_prestamo"),
                        rs.getString("fecha_limite"),
                        rs.getString("fecha_devolucion"),
                        rs.getString("estado"),
                        null,
                        null
                    );
                }
            }
        }
        return null;
    }

    public List<Prestamo> listarPorUsuario(int idUsuario) throws SQLException {
        List<Prestamo> prestamos = new ArrayList<>();
        String sql = "SELECT p.*, CONCAT(l.titulo, ' - ', l.autor) AS titulo_libro \n" + //
                        "FROM prestamos p\n" + //
                        "JOIN libros l ON p.id_libro = l.id_libro\n" + //
                        "WHERE p.id_usuario = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prestamo prestamo = new Prestamo(
                        rs.getInt("id_prestamo"),
                        rs.getInt("id_usuario"),
                        rs.getInt("id_libro"),
                        rs.getString("fecha_prestamo"),
                        rs.getString("fecha_limite"),
                        rs.getString("fecha_devolucion"),
                        rs.getString("estado"),
                        rs.getString("titulo_libro"),
                        null
                    );
                    prestamos.add(prestamo);
                }
            }
        }
        return prestamos;
    }

    public List<Prestamo> buscarPorLibro(int idLibro) throws SQLException {
        List<Prestamo> prestamos = new ArrayList<>();
        String sql = "SELECT * FROM prestamos WHERE id_libro = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idLibro);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prestamo prestamo = new Prestamo(
                        rs.getInt("id_prestamo"),
                        rs.getInt("id_usuario"),
                        rs.getInt("id_libro"),
                        rs.getString("fecha_prestamo"),
                        rs.getString("fecha_limite"),
                        rs.getString("fecha_devolucion"),
                        rs.getString("estado"),
                        null,
                        null
                    );
                    prestamos.add(prestamo);
                }
            }
        }
        return prestamos;
    }

/* insertar nuevo préstamo*/ 
    public void insertar(Prestamo prestamo) throws SQLException {
        String sql = "INSERT INTO prestamos (id_usuario, id_libro, fecha_prestamo, fecha_limite, fecha_devolucion, estado) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, prestamo.getIdUsuario());
            ps.setInt(2, prestamo.getIdLibro());
            ps.setString(3, prestamo.getFechaPrestamo());
            ps.setString(4, prestamo.getFechaLimite());
            ps.setString(5, prestamo.getFechaDevolucion());
            ps.setString(6, prestamo.getEstado());

            ps.executeUpdate();
        }
    }


// devolver un libro (actualizar estado y fecha de devolución)
    public void devolver(int idPrestamo, String fechaDevolucion) throws SQLException {
        String sql = "UPDATE prestamos SET fecha_devolucion = ?, estado = 'DEVUELTO' WHERE id_prestamo = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fechaDevolucion);
            ps.setInt(2, idPrestamo);

            ps.executeUpdate();
        }
    }

    public int contarActivos() throws SQLException {
    String sql = "SELECT COUNT(*) FROM prestamos WHERE estado = 'ACTIVO'";
    try (Connection conn = ConexionDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
            return rs.getInt(1);
        }
    }
    return 0;
}

public int contarAtrasados() throws SQLException {
    String sql = "SELECT COUNT(*) FROM prestamos WHERE estado = 'ATRASADO'";
    try (Connection conn = ConexionDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
            return rs.getInt(1);
        }
    }
    return 0;
}


}
