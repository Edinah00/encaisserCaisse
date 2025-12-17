package DAO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import Model.ConnectionDB;
import Model.Mouvement;

public class MouvementDAO {

    public static BigDecimal getTotalDebit(String numeroCompte) throws Exception {
        String sql = "SELECT SUM(montant) AS total_debit FROM mouvement WHERE numero_compte = ? AND type = 'debit'";
        ConnectionDB db = new ConnectionDB();

        try (Connection conn = db.getConnexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, numeroCompte);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal result = rs.getBigDecimal("total_debit");
                    return (result != null) ? result : BigDecimal.ZERO;
                }
            }
        }

        return BigDecimal.ZERO;
    }

    public static BigDecimal getTotalCredit(String numeroCompte) throws Exception {
        String sql = "SELECT SUM(montant) AS total_credit FROM mouvement WHERE numero_compte = ? AND type = 'credit'";
        ConnectionDB db = new ConnectionDB();

        try (Connection conn = db.getConnexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, numeroCompte);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal result = rs.getBigDecimal("total_credit");
                    return (result != null) ? result : BigDecimal.ZERO;
                }
            }
        }

        return BigDecimal.ZERO;
    }
public static void save(Connection conn, Mouvement m) throws SQLException {
    String sql = "INSERT INTO mouvement (numero_compte, type, montant) VALUES (?, ?, ?)";

    try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        ps.setString(1, m.getNumero_compte());
        ps.setString(2, m.getType());
        ps.setBigDecimal(3, m.getMontant()); // ✅ ICI LA CORRECTION

        ps.executeUpdate();

        try (ResultSet rs = ps.getGeneratedKeys()) {
            if (rs.next()) {
                m.setId_mouv(rs.getInt(1));
            }
        }
    }
}

}
