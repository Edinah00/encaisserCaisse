package Model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

public class ChequeEtat {
    private int id_ChequeEtat;
    private int id_cheque;
    private int id_etat;
    private Date daty;
    private String Beneficiaire;

    public Date getDaty() {
        return daty;
    }

    public int getId_ChequeEtat() {
        return id_ChequeEtat;
    }

    public int getId_cheque() {
        return id_cheque;
    }

    public int getId_etat() {
        return id_etat;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public void setId_ChequeEtat(int id_ChequeEtat) {
        this.id_ChequeEtat = id_ChequeEtat;
    }

    public void setId_cheque(int id_cheque) {
        this.id_cheque = id_cheque;
    }

    public void setId_etat(int id_etat) {
        this.id_etat = id_etat;
    }

    public String getBeneficiaire() {
        return Beneficiaire;
    }

    public void setBeneficiaire(String beneficiaire) {
        Beneficiaire = beneficiaire;
    }

    public ChequeEtat(int chequeEtat, int cheque, int etat, Date daty) {
        setDaty(daty);
        setId_ChequeEtat(chequeEtat);
        setId_cheque(cheque);
        setId_etat(etat);
    }

    public ChequeEtat() {

    }

    public void insertIntoEtat(Connection conn, Cheque a) throws SQLException, Exception {
        String sql = "insert into ChequeEtat(id_cheque,id_etat,date_etat,beneficiaire) values (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, a.getId_Cheque());
            ps.setInt(2, this.getId_etat());
            ps.setDate(3, java.sql.Date.valueOf(LocalDate.now())); // date actuelle
            ps.setString(4, this.getBeneficiaire());

            ps.executeUpdate();
        }
    }

    public void updateEtat(Connection conn) {

        String sql = "UPDATE ChequeEtat SET id_etat = ? WHERE id_cheque = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, this.getId_etat());
            ps.setInt(2, this.getId_cheque());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateEtat() throws Exception {
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnexion()) {
            updateEtat(con);
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la mis a jour");
        }
    }
}
