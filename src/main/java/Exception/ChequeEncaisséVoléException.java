package Exception;
public class ChequeEncaisséVoléException extends Exception{
      String numero_Cheque;
      String etat;
    public String getNumero_Cheque() {
        return numero_Cheque;

    }
    public void setNumero_Cheque(String numero_Cheque) {
        this.numero_Cheque = numero_Cheque;
    }
    public String getEtat() {
        return etat;
    }
    public void setEtat(String etat) {
        this.etat = etat;
    }

}
