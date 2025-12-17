package Exception;
public class ChequeNotFoundException extends Exception {
    String numero_Cheque;
    public String getNumero_Cheque() {
        return numero_Cheque;
    }
    public void setNumero_Cheque(String numero_Cheque) {
        this.numero_Cheque = numero_Cheque;
    }
}
