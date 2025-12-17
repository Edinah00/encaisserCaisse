package DAO;
import java.security.spec.ECFieldF2m;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Statement;

import Model.ConnectionDB;
import Model.EtatCheque;


public class EtatChequeDAO {
    public static void getId_etat(EtatCheque etatCheque) throws Exception{
        try{
            ConnectionDB db = new ConnectionDB();
            Connection conn = db.getConnexion();
            getId_etat(etatCheque, conn);
            conn.close();
        }catch(SQLException e){
           System.out.println("Id_non trouvé:"  + e.getMessage());
        }
    }
    public static void getId_etat(EtatCheque etatCheque,Connection conn) throws Exception{
        try{
             String sql = "select * from EtatCheque where id_etat = ?";
        PreparedStatement pStatement = conn.prepareStatement(sql);
        pStatement.setInt(1, etatCheque.getId_etat());
        ResultSet rs = pStatement.executeQuery();
        while (rs.next()) {
            etatCheque.setNameEtat(rs.getString("etat"));
        }
        rs.close();
        }catch(Exception e){
           System.out.println("Id_non trouvé:"  + e.getMessage());
        }
       
    }
public static ArrayList<EtatCheque> getAllEtat() throws Exception {
    ArrayList<EtatCheque> list = new ArrayList<>();

    try {
        ConnectionDB db = new ConnectionDB();

        try (Connection conn = db.getConnexion()) {
            list = getAllEtat(conn); // ✅ on récupère la vraie liste
        }

    } catch (SQLException e) {
        System.out.println("Find all n'a pas marché : " + e.getMessage());
    }

    return list;// ✅ jamais null
}

 public static ArrayList<EtatCheque> getAllEtat(Connection conn) {
    ArrayList<EtatCheque> list = new ArrayList<>();
    String sql = "SELECT * FROM EtatCheque";

    try (
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)
    ) {
        while (rs.next()) {
            EtatCheque etat = new EtatCheque();
            etat.setId_etat(rs.getInt("id_etat"));
            etat.setNameEtat(rs.getString("etat"));
            list.add(etat);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}


}
