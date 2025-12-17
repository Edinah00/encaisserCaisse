package Model;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;

public class Cheque {
    private int id_Cheque;
     private String numero_Cheque;
     private String numero_Compte;
     private Date date_limite;
     public int getId_Cheque() {
         return id_Cheque;
     }

     public Date getDate_limite() {
         return date_limite;
     }
     public String getNumero_Cheque() {
         return numero_Cheque;
     }
     public String getNumero_Compte() {
         return numero_Compte;
     }
     public void setDate_limite(Date date_limite) {
         this.date_limite = date_limite;
     }
     public void setId_Cheque(int id_Cheque) {
         this.id_Cheque = id_Cheque;
     }
     public void setNumero_Cheque(String numero_Cheque) {
         this.numero_Cheque = numero_Cheque;
     }
     public void setNumero_Compte(String numero_Compte) {
         this.numero_Compte = numero_Compte;
     }

     public Cheque(String numero_Cheque , String numero_compte , Date date_limite){
        setDate_limite(date_limite);
      //  setId_Cheque(id_Cheque);
        setNumero_Cheque(numero_Cheque);
        setNumero_Compte(numero_compte);
     }
     public Cheque(){

     }
}
