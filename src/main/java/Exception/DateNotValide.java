package Exception;
import java.sql.Date;
import java.time.LocalDate;

public class DateNotValide extends Exception{
    Date daty ;
    String numero_cheque;

    public Date getDaty() {
        return daty;
    }
    public String getNumero_cheque() {
        return numero_cheque;
    }
    public void setDaty(Date daty) {
        this.daty = daty;
    }
    public void setNumero_cheque(String numero_cheque) {
        this.numero_cheque = numero_cheque;
    }
}
