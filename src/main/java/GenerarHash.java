import org.mindrot.jbcrypt.BCrypt;

public class GenerarHash {
    public static void main(String[] args) {
        String hash = BCrypt.hashpw("admin123", BCrypt.gensalt());
        System.out.println(hash);
    }
}

