package com.untec.biblioteca.model;

public class Libro {

    private int idLibro;
    private String isbn;
    private String titulo;
    private String autor;
    private int anioPublicacion;
    private String editorial;
    private String categoria;
    private boolean disponible;

    // Constructor vacío
    public Libro() {}

    // Constructor completo
    public Libro(int idLibro, String isbn, String titulo, String autor,
                 int anioPublicacion, String editorial, String categoria, boolean disponible) {
        this.idLibro = idLibro;
        this.isbn = isbn;
        this.titulo = titulo;
        this.autor = autor;
        this.anioPublicacion = anioPublicacion;
        this.editorial = editorial;
        this.categoria = categoria;
        this.disponible = disponible;
    }

    // Getters y Setters
    public int getIdLibro() { return idLibro; }
    public void setIdLibro(int idLibro) { this.idLibro = idLibro; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getAutor() { return autor; }
    public void setAutor(String autor) { this.autor = autor; }

    public int getAnioPublicacion() { return anioPublicacion; }
    public void setAnioPublicacion(int anioPublicacion) { this.anioPublicacion = anioPublicacion; }

    public String getEditorial() { return editorial; }
    public void setEditorial(String editorial) { this.editorial = editorial; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }
}
