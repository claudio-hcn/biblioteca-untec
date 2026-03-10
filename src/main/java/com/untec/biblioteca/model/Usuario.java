package com.untec.biblioteca.model;

public class Usuario {

    private int idUsuario;
    private String nombre;
    private String rut;
    private String email;
    private String password;
    private String carrera;
    private String fechaNacimiento;
    private String rol;
    private boolean activo;

    // Constructor vacío
    public Usuario() {}

    // Constructor completo
    public Usuario(int idUsuario, String nombre, String rut, String email,
                   String password, String carrera, String fechaNacimiento, String rol, boolean activo) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.rut = rut;
        this.email = email;
        this.password = password;
        this.carrera = carrera;
        this.fechaNacimiento = fechaNacimiento;
        this.rol = rol;
        this.activo = activo;
    }

    // Getters y Setters
    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getRut() { return rut; }
    public void setRut(String rut) { this.rut = rut; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getCarrera() { return carrera; }
    public void setCarrera(String carrera) { this.carrera = carrera; }

    public String getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(String fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}