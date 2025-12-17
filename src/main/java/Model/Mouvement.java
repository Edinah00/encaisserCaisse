package Model;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;

public class Mouvement {
    private int id_mouv;
    private String numero_compte;
    private Date date ;
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
    public Mouvement(){
        
    }
    public Mouvement(int mvt,Date date,String numCompte,String type , BigDecimal montant){
        setType(type);
        setId_mouv(mvt);
        setMontant(montant);
        setNumero_compte(numCompte);
        setDate(date);
    }
   
    
}
