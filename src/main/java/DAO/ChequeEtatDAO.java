package DAO;

import java.sql.Date;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;

import Model.Cheque;
import Model.ChequeEtat;
import Model.ConnectionDB;
import Model.EtatCheque;

public class ChequeEtatDAO {
    public static String getChequeAvecEtat(ChequeEtat a, Connection conn) throws Exception {
        String nom_Etat = null;
        try {
            String sql = "select * from ChequeEtat where id_cheque= ? order by date_etat desc limit 1";
            PreparedStatement pStatement = conn.prepareStatement(sql);
            pStatement.setInt(1, a.getId_cheque());
            ResultSet rs = pStatement.executeQuery();
            if (rs.next()) {
                a.setId_etat(rs.getInt("id_etat"));
                EtatCheque et = new EtatCheque();
                et.setId_etat(a.getId_etat());
                EtatChequeDAO.getId_etat(et, conn);

                nom_Etat = et.getNameEtat();
            }
            rs.close();
        } catch (SQLException e) {

        }
        return nom_Etat;
    }

    public static String getChequeAvecEtat(ChequeEtat a) throws Exception {
        Connection conn = null;
        try {
            ConnectionDB db = new ConnectionDB();
            conn = db.getConnexion();
            return getChequeAvecEtat(a, conn);
            // conn.close();
        } catch (SQLException e) {
            // TODO: handle exception
        }
        return null;
    }

    public static void getChequeAvecIdEtat(ChequeEtat a, Connection conn) throws Exception {
        try {
            String sql = "select id_etat from ChequeEtat where id_cheque= ? order by date_etat desc limit 1";
            PreparedStatement pStatement = conn.prepareStatement(sql);
            pStatement.setInt(1, a.getId_cheque());
            ResultSet rs = pStatement.executeQuery();
            if (rs.next()) {
                a.setId_etat(rs.getInt("id_etat"));
            }
            rs.close();
        } catch (SQLException e) {

        }
    }

    public static void getChequeAvecIdEtat(ChequeEtat a) throws Exception {
        Connection conn = null;
        try {
            ConnectionDB db = new ConnectionDB();
            conn = db.getConnexion();
            getChequeAvecIdEtat(a, conn);
            // conn.close();
        } catch (SQLException e) {
            // TODO: handle exception
        }
    }

    public static void remove(ChequeEtat chequeEtat) throws Exception {
        ConnectionDB db = new ConnectionDB();

        try (Connection con = db.getConnexion()) {
            // 1️ Supprimer les dépendances
            String sqlEtat = "DELETE FROM ChequeEtat WHERE id_chequeEtat = ?";
            try (PreparedStatement pstmt1 = con.prepareStatement(sqlEtat)) {
                pstmt1.setInt(1, chequeEtat.getId_ChequeEtat());
                pstmt1.executeUpdate();
            }
        }
    }

    public static ArrayList<ChequeEtat> findAllChequeEtatByCheque(Connection conn, ChequeEtat chE) throws SQLException {
        ArrayList<ChequeEtat> listeChequeEtat = new ArrayList<>();

        String sql = "SELECT * FROM ChequeEtat where id_cheque = ?";
        try (PreparedStatement pStatement = conn.prepareStatement(sql)) {
            pStatement.setInt(1, chE.getId_cheque());

            try (ResultSet rs = pStatement.executeQuery()) {

                while (rs.next()) {
                    ChequeEtat a = new ChequeEtat();
                    a.setId_ChequeEtat(rs.getInt("id_chequeEtat"));
                    a.setId_cheque(rs.getInt("id_cheque"));
                    a.setId_etat(rs.getInt("id_etat"));
                    a.setDaty(rs.getDate("date_etat"));
                    a.setBeneficiaire(rs.getString("beneficiaire"));

                    listeChequeEtat.add(a);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listeChequeEtat;
    }

    public static ArrayList<ChequeEtat> findAllChequeEtatByCheque(ChequeEtat chE) throws Exception {
        Connection conn = null;

        try {
            ConnectionDB db = new ConnectionDB();
            conn = db.getConnexion();
            return findAllChequeEtatByCheque(conn, chE);
        } catch (SQLException e) {
            throw new SQLException(
                    "Erreur lors de la récupération de tous les ChequesSqtus par Cheque : " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Erreur lors de la fermeture de la connexion : " + e.getMessage());
                }
            }
        }
    }
   
    public static void update(Connection conn, ChequeEtat a) throws SQLException {
        PreparedStatement pstmt = null;
        try {
            
            String sql = "UPDATE ChequeEtat SET id_etat = ?, date_etat = ?, beneficiaire = ? WHERE id_chequeEtat = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, a.getId_etat());
            LocalDate today = LocalDate.now();  // date actuelle
            pstmt.setDate(2, Date.valueOf(today));
            pstmt.setString(3, a.getBeneficiaire());
            pstmt.setInt(4, a.getId_ChequeEtat());

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                System.out.println("ChequeEtat mis à jour avec succès !");
            }
            
            
        } catch (SQLException e) {
                    System.err.println("mis a jour non effectue : " + e.getMessage());
            }
          
    }

    public static  void update(ChequeEtat a) throws Exception {
        Connection conn = null;
        try {
            ConnectionDB db = new ConnectionDB();
            conn = db.getConnexion();
            update(conn, a);
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la mise à jour : " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Erreur lors de la fermeture de la connexion : " + e.getMessage());
                }
            }
        }
    }
 public static void findById(ChequeEtat etat) throws Exception {
        if (etat == null) return; 

        Connection conn = null;
        ConnectionDB db = new ConnectionDB();

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = db.getConnexion();
            String sql = "SELECT * FROM ChequeEtat WHERE id_ChequeEtat = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, etat.getId_ChequeEtat()); // utilise l'ID déjà défini dans l'objet
            rs = ps.executeQuery();

            if (rs.next()) {
                etat.setId_cheque(rs.getInt("id_cheque"));
                etat.setId_etat(rs.getInt("id_etat"));
                etat.setDaty(rs.getDate("date_etat"));
                etat.setBeneficiaire(rs.getString("beneficiaire"));
            } else {
                System.out.println("Aucun ChequeEtat trouvé pour l'ID " + etat.getId_ChequeEtat());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

}
