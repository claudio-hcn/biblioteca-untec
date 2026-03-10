package com.untec.biblioteca.dao;

import com.untec.biblioteca.model.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

    public class UsuarioDAO {

public List<Usuario> listarTodos() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario(
                    rs.getInt("id_usuario"),
                    rs.getString("nombre"),
                    rs.getString("rut"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("carrera"),
                    rs.getString("fecha_nacimiento"),
                    rs.getString("rol"),
                    rs.getBoolean("activo")
                );
                usuarios.add(usuario);
            }
        }
        return usuarios;


    }
 public Usuario buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("nombre"),
                        rs.getString("rut"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("carrera"),
                        rs.getString("fecha_nacimiento"),
                        rs.getString("rol"),
                        rs.getBoolean("activo")
                    );
                }
            }
        }
        return null;
    }

    public Usuario buscarPorEmail(String email) throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE email = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("nombre"),
                        rs.getString("rut"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("carrera"),
                        rs.getString("fecha_nacimiento"),
                        rs.getString("rol"),
                        rs.getBoolean("activo")
                    );
                }
            }
        }
        return null;
        
    }

    public void insertar(Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, rut, email, password, carrera, fecha_nacimiento, rol, activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getRut());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getPassword());
            ps.setString(5, usuario.getCarrera());
            ps.setString(6, usuario.getFechaNacimiento());
            ps.setString(7, usuario.getRol());

            ps.executeUpdate();
        }
    }

    public void actualizar(Usuario usuario) throws SQLException {
        String sql = "UPDATE usuarios SET nombre = ?, rut = ?, email = ?, password = ?, carrera = ?, fecha_nacimiento = ?, rol = ? WHERE id_usuario = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getRut());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getPassword());
            ps.setString(5, usuario.getCarrera());
            ps.setString(6, usuario.getFechaNacimiento());
            ps.setString(7, usuario.getRol());
            ps.setInt(8, usuario.getIdUsuario());

            ps.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public int contarUsuarios() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM usuarios where rol = 'USUARIO'";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public void toggleActivo(int idUsuario, boolean activo) throws SQLException {
    String sql = "UPDATE usuarios SET activo = ? WHERE id_usuario = ?";
    try (Connection conn = ConexionDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setBoolean(1, activo);
        ps.setInt(2, idUsuario);
        ps.executeUpdate();
    }
}
}