package Controller;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.ArrayList;

import DAO.ChequeDAO;
import DAO.Service.Service;
import Exception.ChequeEncaisséVoléException;
import Exception.DateNotValide;
import Exception.MontantInsuffisantException;
import Model.ConnectionDB;
import Model.FormEncaissement;
import Model.Mouvement;
import Exception.ChequeNotFoundException;
import Model.Cheque;


public class Main {

    public static void main(String[] args) throws Exception {
        try {
            ConnectionDB db = new ConnectionDB();
            Connection conn= db.getConnexion();
            FormEncaissement form = new FormEncaissement();
            java.sql.Date d = java.sql.Date.valueOf("2025-12-31");
     
            form.setDate_limite(d);
            form.setMontant(BigDecimal.valueOf(2));
            form.setNumero_cheque("CHQ005");
            form.setNom_beneficiaire("RABE");
            Mouvement a = new Mouvement();
           // Service.VerifierMontant(a, form);
        //   Service.encaisserCheque(form);
        } catch (ChequeEncaisséVoléException e) {
            // TODO: handle exception
            System.out.println("le cheque num:"+ e.getNumero_Cheque() + " est "+ e.getEtat());

        }catch(ChequeNotFoundException e){
            System.out.println("Le cheque numero :"+ e.getNumero_Cheque() +" non trouve ");
        }catch(DateNotValide ex){
            System.out.println("La date limite :" + ex.getDaty() + " du cheque num " + ex.getNumero_cheque()+" n'est plus valide " );
        }catch(MontantInsuffisantException e){
            System.out.println("Le montant que vous avez dans votre compte  est insuffisant , veuillez inserer un montant inferieur a "+ e.getMontantDemande() );
        }

    }
}