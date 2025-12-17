package Exception;
import java.math.BigDecimal;

public class MontantInsuffisantException extends Exception {

    private String numero_cheque;
    private BigDecimal montantDemande;

   public void setMontantDemande(BigDecimal montantDemande) {
       this.montantDemande = montantDemande;
   }
   public void setNumero_cheque(String numero_cheque) {
       this.numero_cheque = numero_cheque;
   }
    public String getNumeroCheque() {
        return numero_cheque;
    }

    public BigDecimal getMontantDemande() {
        return montantDemande;
    }
}
