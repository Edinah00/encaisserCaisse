package Model;
import java.math.BigDecimal;
import java.sql.Date;

public class FormEncaissement {

    private String numero_cheque;
    private String nom_beneficiaire;
    private BigDecimal montant;
    private Date date_limite;   // <-- Manquait !

    public FormEncaissement(String numero_cheque, String nom_beneficiaire, BigDecimal montant, Date date_limite) {
        this.numero_cheque = numero_cheque;
        this.nom_beneficiaire = nom_beneficiaire;
        this.montant = montant;
        this.date_limite = date_limite;
    }
    public FormEncaissement(){
        
    }

    public String getNumero_cheque() {
        return numero_cheque;
    }

    public String getNom_beneficiaire() {
        return nom_beneficiaire;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public Date getDate_limite() {
        return date_limite;
    }

    public void setNumero_cheque(String numero_cheque) {
        this.numero_cheque = numero_cheque;
    }

    public void setNom_beneficiaire(String nom_beneficiaire) {
        this.nom_beneficiaire = nom_beneficiaire;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    public void setDate_limite(Date date_limite) {
        this.date_limite = date_limite;
    }
}
