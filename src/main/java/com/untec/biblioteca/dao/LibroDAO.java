package com.untec.biblioteca.dao;

import com.untec.biblioteca.model.Libro;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LibroDAO {

    // Listar todos los libros
    public List<Libro> listarTodos() throws SQLException {
        List<Libro> libros = new ArrayList<>();
        String sql = "SELECT * FROM libros";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Libro libro = new Libro(
                    rs.getInt("id_libro"),
                    rs.getString("isbn"),
                    rs.getString("titulo"),
                    rs.getString("autor"),
                    rs.getInt("anio_publicacion"),
                    rs.getString("editorial"),
                    rs.getString("categoria"),
                    rs.getBoolean("disponible")
                );
                libros.add(libro);
            }
        }
        return libros;
    }

    // Buscar libro por ID
    public Libro buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM libros WHERE id_libro = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Libro(
                        rs.getInt("id_libro"),
                        rs.getString("isbn"),
                        rs.getString("titulo"),
                        rs.getString("autor"),
                        rs.getInt("anio_publicacion"),
                        rs.getString("editorial"),
                        rs.getString("categoria"),
                        rs.getBoolean("disponible")
                    );
                }
            }
        }
        return null;
    }

    // Insertar nuevo libro
    public void insertar(Libro libro) throws SQLException {
        String sql = "INSERT INTO libros (isbn, titulo, autor, anio_publicacion, editorial, categoria, disponible) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, libro.getIsbn());
            ps.setString(2, libro.getTitulo());
            ps.setString(3, libro.getAutor());
            ps.setInt(4, libro.getAnioPublicacion());
            ps.setString(5, libro.getEditorial());
            ps.setString(6, libro.getCategoria());
            ps.setBoolean(7, libro.isDisponible());
            ps.executeUpdate();
        }
    }

    // Actualizar libro
    public void actualizar(Libro libro) throws SQLException {
        String sql = "UPDATE libros SET isbn=?, titulo=?, autor=?, anio_publicacion=?, editorial=?, categoria=?, disponible=? WHERE id_libro=?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, libro.getIsbn());
            ps.setString(2, libro.getTitulo());
            ps.setString(3, libro.getAutor());
            ps.setInt(4, libro.getAnioPublicacion());
            ps.setString(5, libro.getEditorial());
            ps.setString(6, libro.getCategoria());
            ps.setBoolean(7, libro.isDisponible());
            ps.setInt(8, libro.getIdLibro());
            ps.executeUpdate();
        }
    }

    // Eliminar libro
    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM libros WHERE id_libro = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public int contarLibros() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM libros";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }
}