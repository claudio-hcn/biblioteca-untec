package com.untec.biblioteca.util;

import java.util.regex.Pattern;
import java.time.LocalDate;
import java.time.DayOfWeek;

public class Validador {

    // Validar RUT chileno
    public static boolean validarRut(String rut) {
        try {
            rut = rut.replace(".", "").replace("-", "").toUpperCase();

            String dvIngresado = String.valueOf(rut.charAt(rut.length() - 1));
            String rutSinDv = rut.substring(0, rut.length() - 1);

            int suma = 0;
            int multiplicador = 2;

            for (int i = rutSinDv.length() - 1; i >= 0; i--) {
                int digito = Character.getNumericValue(rutSinDv.charAt(i));
                suma += digito * multiplicador;
                multiplicador++;
                if (multiplicador > 7) multiplicador = 2;
            }

            int resto = suma % 11;
            int dvCalculado = 11 - resto;

            String dv;
            if (dvCalculado == 11) dv = "0";
            else if (dvCalculado == 10) dv = "K";
            else dv = String.valueOf(dvCalculado);

            return dv.equals(dvIngresado);

        } catch (Exception e) {
            return false;
        }
    }

    // Validar email
    public static boolean validarEmail(String email) {
        String regex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        return Pattern.matches(regex, email);
    }

    // Validar password seguro
    public static boolean validarPassword(String password) {
        // Mínimo 8 caracteres
        if (password.length() < 8) return false;
        // Al menos una mayúscula
        if (!password.matches(".*[A-Z].*")) return false;
        // Al menos un número
        if (!password.matches(".*[0-9].*")) return false;
        // Al menos un carácter especial
        if (!password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{}].*")) return false;
        return true;
    }

    // Validar nombre (solo letras y espacios)
    public static boolean validarNombre(String nombre) {
        return nombre != null && nombre.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$");
    }

    public static LocalDate calcularFechaLimite(LocalDate fechaInicio, int diasHabiles) {
    LocalDate fecha = fechaInicio;
    int diasContados = 0;

    while (diasContados < diasHabiles) {
        fecha = fecha.plusDays(1);
        if (fecha.getDayOfWeek() != DayOfWeek.SATURDAY && 
            fecha.getDayOfWeek() != DayOfWeek.SUNDAY) {
            diasContados++;
        }
    }
    return fecha;
}
}
