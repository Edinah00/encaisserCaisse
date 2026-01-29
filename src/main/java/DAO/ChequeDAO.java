package DAO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import Model.Cheque;
import Model.ConnectionDB;

public class ChequeDAO {

public static void remove(Cheque cheque) throws Exception {
    ConnectionDB db = new ConnectionDB();

    try (Connection con = db.getConnexion()) {
        // 1️ Supprimer les dépendances
        String sqlEtat = "DELETE FROM ChequeEtat WHERE id_cheque = ?";
        try (PreparedStatement pstmt1 = con.prepareStatement(sqlEtat)) {
            pstmt1.setInt(1, cheque.getId_Cheque());
            pstmt1.executeUpdate();
        }

        // 2 Supprimer le chèque
        String sqlCheque = "DELETE FROM Cheque WHERE id_cheque = ?";
        try (PreparedStatement pstmt2 = con.prepareStatement(sqlCheque)) {
            pstmt2.setInt(1, cheque.getId_Cheque());
            pstmt2.executeUpdate();
        }
    }
}


public static ArrayList<Cheque> findAllCheque(Connection conn) {
        ArrayList<Cheque> listeCheque = new ArrayList<>();

        String sql = "SELECT * FROM Cheque";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
             
            while (rs.next()) {
                Cheque a = new Cheque();
                a.setId_Cheque(rs.getInt("id_cheque"));
                a.setNumero_Cheque(rs.getString("numero_cheque"));
                a.setNumero_Compte(rs.getString("numero_compte"));
                a.setDate_limite(rs.getDate("date_limite"));

                listeCheque.add(a); 
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    return listeCheque;
}
     
public static ArrayList<Cheque> findAllCheque() throws Exception {
    Connection conn = null;


    try {
        ConnectionDB db = new ConnectionDB();
        conn= db.getConnexion();
        return findAllCheque(conn);
      } catch (SQLException e) {
            throw new SQLException("Erreur lors de la récupération de tous les étudiants : " + e.getMessage());
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

public static boolean findByQqch(Cheque a, Connection conn) throws Exception {
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String num = a.getNumero_Cheque();

        String sql = "SELECT * FROM Cheque WHERE numero_cheque = ? ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, num);

        rs = pstmt.executeQuery();
  
        if (rs.next()) {
            a.setId_Cheque(rs.getInt("id_cheque"));
            a.setNumero_Compte(rs.getString("numero_compte"));
            a.setDate_limite(rs.getDate("date_limite"));
            System.out.println("Élément trouvé");
            return true;
        }

        return false;
    } 
    finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
    }
}


    public static boolean findByQqch(Cheque a) throws Exception {
        Connection conn = null;
        try {
            ConnectionDB db = new ConnectionDB();
            conn = db.getConnexion();
            boolean  bol =findByQqch(a, conn);
            return bol;
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la recherche par ID : " + e.getMessage());
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

 public static void insert(Cheque a, Connection conn) throws Exception {

    String sql = "INSERT INTO Cheque(numero_cheque, numero_compte, date_limite) VALUES (?, ?, ?)";

    try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        ps.setString(1, a.getNumero_Cheque());
        ps.setString(2, a.getNumero_Compte());
        ps.setDate(3, a.getDate_limite());

        ps.executeUpdate();

        // ✅ RÉCUPÉRATION OBLIGATOIRE DE L'ID
        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            a.setId_Cheque(rs.getInt(1));   // ⭐ LIGNE LA PLUS IMPORTANTE
        }
    }
}

public static void findById(Cheque a, Connection conn) throws Exception {
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        int num = a.getId_Cheque();

        String sql = "SELECT * FROM Cheque WHERE id_cheque = ? ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, num);

        rs = pstmt.executeQuery();
  
        if (rs.next()) {
            a.setNumero_Cheque(rs.getString("numero_cheque"));
            a.setNumero_Compte(rs.getString("numero_compte"));
            a.setDate_limite(rs.getDate("date_limite"));
            System.out.println("Élément trouvé");
           // return true;
        }

      //  return false;
    } 
    finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
    }
}


    public static void findById(Cheque a) throws Exception {
        Connection conn = null;
        try {
            ConnectionDB db = new ConnectionDB();
            conn = db.getConnexion();
            findById(a, conn);
        } catch (SQLException e) {
            throw new SQLException("Erreur lors de la recherche par ID : " + e.getMessage());
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
    public static void update(Connection conn, Cheque a) throws SQLException {
        PreparedStatement pstmt = null;
        try {
            
            String sql = "UPDATE Cheque SET numero_cheque = ?, numero_compte = ?, date_limite = ? WHERE id_cheque = ?";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, a.getNumero_Cheque());
            pstmt.setString(2, a.getNumero_Compte());
            pstmt.setDate(3, a.getDate_limite());
            pstmt.setInt(4, a.getId_Cheque());

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                System.out.println("Cheque mis à jour avec succès !");
            }
            
        } catch (SQLException e) {
          
                    System.err.println("mis a jour non effectue : " + e.getMessage());
                
            }
          
    }

    public static  void update(Cheque a) throws Exception {
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


    
}
