package Model;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

public class Mouvement {
    private int id_mouv;
    private String numero_compte;
    private Date date;
    private String type;
    private BigDecimal montant;

    public int getId_mouv() {
        return id_mouv;
    }

    public Date getDate() {
        return date;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public String getNumero_compte() {
        return numero_compte;
    }

    public String getType() {
        return type;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setMontant(BigDecimal montant2) {
        this.montant = montant2;
    }

    public void setNumero_compte(String numero_compte) {
        this.numero_compte = numero_compte;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setId_mouv(int id_mouv) {
        this.id_mouv = id_mouv;
    }

    public Mouvement() {

    }

    public Mouvement(int mvt, Date date, String numCompte, String type, BigDecimal montant) {
        setType(type);
        setId_mouv(mvt);
        setMontant(montant);
        setNumero_compte(numCompte);
        setDate(date);
    }

    public static ArrayList<Mouvement> findAllMouvement() throws Exception {
        ArrayList<Mouvement> listeMouvements = new ArrayList<>();
        String sql = "SELECT id_mouvement, numero_compte, date_mouvement, type, montant FROM mouvement";
        ConnectionDB db = new ConnectionDB();
        Connection conn = db.getConnexion();
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("id_mouvement");
                String compte = rs.getString("numero_compte");
                Date date = rs.getDate("date_mouvement");
                String type = rs.getString("type");
                BigDecimal montant = rs.getBigDecimal("montant");
                Mouvement mvt = new Mouvement(id, date, compte, type, montant);
                listeMouvements.add(mvt);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des mouvements : " + e.getMessage());
        }
        return listeMouvements;
    }
    public static ArrayList<Mouvement> searchMouvements(
        ArrayList<Mouvement> mouvements,
        String numeroCompte,
        String type,
        Date dateDebut, String dateDebutOp,
        Date dateFin, String dateFinOp,
        BigDecimal montantMin, String montantMinOp,
        BigDecimal montantMax, String montantMaxOp) {

    ArrayList<Mouvement> resultats = new ArrayList<>();

    for (Mouvement m : mouvements) {
        boolean match = true;

        // Numéro de compte
        if (numeroCompte != null && !numeroCompte.isEmpty()) {
            if (!m.getNumero_compte().equalsIgnoreCase(numeroCompte)) match = false;
        }

        // Type
        if (type != null && !type.isEmpty()) {
            if (!m.getType().equalsIgnoreCase(type)) match = false;
        }

        // Date début
        if (dateDebut != null) {
            switch (dateDebutOp) {
                case ">": if (!(m.getDate().after(dateDebut))) match = false; break;
                case ">=": if (m.getDate().before(dateDebut)) match = false; break;
                case "=": if (!m.getDate().equals(dateDebut)) match = false; break;
            }
        }

        // Date fin
        if (dateFin != null) {
            switch (dateFinOp) {
                case "<": if (!(m.getDate().before(dateFin))) match = false; break;
                case "<=": if (m.getDate().after(dateFin)) match = false; break;
                case "=": if (!m.getDate().equals(dateFin)) match = false; break;
            }
        }

        // Montant min
        if (montantMin != null) {
            switch (montantMinOp) {
                case ">": if (m.getMontant().compareTo(montantMin) <= 0) match = false; break;
                case ">=": if (m.getMontant().compareTo(montantMin) < 0) match = false; break;
                case "=": if (m.getMontant().compareTo(montantMin) != 0) match = false; break;
            }
        }

        // Montant max
        if (montantMax != null) {
            switch (montantMaxOp) {
                case "<": if (m.getMontant().compareTo(montantMax) >= 0) match = false; break;
                case "<=": if (m.getMontant().compareTo(montantMax) > 0) match = false; break;
                case "=": if (m.getMontant().compareTo(montantMax) != 0) match = false; break;
            }
        }

        if (match) resultats.add(m);
    }

    return resultats;
}

}
