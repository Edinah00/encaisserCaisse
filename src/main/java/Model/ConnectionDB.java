package Model;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionDB {
    public  Connection getConnexion()throws Exception{
        String url = "jdbc:mysql://localhost:3306/encaisserCaisse";
        String user = "root";
        String password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
             Connection conn = DriverManager.getConnection(url, user, password);
          //  System.out.println(conn);
            return conn;
           
        } catch (Exception e) {
            // TODO: handle exception
            throw new Exception("Erreur dans la connexion MYSQL");
        }
        
    }
    public void getClose(Connection conn)throws Exception{
        try {
            conn.close();
            System.out.println("Fermeture de la connexion avec succée!!!");
        } catch (Exception e) {
            // TODO: handle exception
            throw new Exception("Erreur lors de la fermeture de la connexion");
        }
    }
}
