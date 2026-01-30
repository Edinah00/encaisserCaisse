package Service;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.util.ArrayList;

import DAO.ChequeDAO;
import DAO.ChequeEtatDAO;
import DAO.MouvementDAO;
import Model.Cheque;
import Model.ChequeEtat;
import Model.ConnectionDB;
import Model.EtatCheque;
import Model.FormEncaissement;
import Model.Mouvement;

import Exception.*;



public class Service {

    public static boolean VerifierNum(FormEncaissement a) throws Exception {
        ArrayList<Cheque> listeDansBD = new ArrayList<>();
        listeDansBD = ChequeDAO.findAllCheque();
        System.out.println(a.getNumero_cheque());
        for (Cheque c : listeDansBD) {
            if (a.getNumero_cheque().equals(c.getNumero_Cheque())) {
                System.out.println(c.getNumero_Cheque());
                return true;
            }
        }
        return false;
    }
   
public static boolean verifierDate(FormEncaissement a) throws Exception {

    Date dateLimite = a.getDate_limite();

    if (dateLimite == null) {
        throw new Exception("La date limite est null !");
    }

    LocalDate dateLimiteLD = dateLimite.toLocalDate();
    LocalDate aujourdHui = LocalDate.now();

    if (dateLimiteLD.isBefore(aujourdHui)) {
        return false; 
    }

    return true; // date valide
}
    

    public static boolean etat(ChequeEtat ce, Cheque a) throws Exception {
        ce.setId_cheque(a.getId_Cheque()); // IMPORTANT !
        String etat = ChequeEtatDAO.getChequeAvecEtat(ce);

        if (etat == null) {
            throw new Exception("Impossible de récupérer l'état du chèque " + a.getNumero_Cheque());
        }

        // 3. Vérifier l'état
        if (!etat.equals("OK")) {
            return false;
        }
        return true;

    }
   public static boolean VerifierMontant(Mouvement a, FormEncaissement b) throws Exception {
    Cheque cheque = new Cheque();
    cheque.setNumero_Cheque(b.getNumero_cheque());
    ChequeDAO.findByQqch(cheque);
    a.setNumero_compte(cheque.getNumero_Compte());

    System.out.println(a.getNumero_compte());
    BigDecimal sommeDebit = MouvementDAO.getTotalDebit(a.getNumero_compte());
    BigDecimal sommeCredit = MouvementDAO.getTotalCredit(a.getNumero_compte());
    System.out.println("somme debit " + sommeDebit);
    System.out.println("Somme credit = "+ sommeCredit);
    // solde = crédit - débit
    BigDecimal solde = sommeCredit.subtract(sommeDebit);

    // compareTo() renvoie :
    // -1 si solde < montant
    //  1 si solde > montant
    if (solde.compareTo(b.getMontant()) < 0) {
        return false; 
    }

    return true; // solde suffisant
}

public void encaisserCheque(FormEncaissement a) throws Exception {

    ChequeEtat E = new ChequeEtat();
    Cheque cheque = new Cheque();
    cheque.setNumero_Cheque(a.getNumero_cheque());
    ChequeDAO.findByQqch(cheque);
    E.setId_cheque(cheque.getId_Cheque());

    Mouvement mouv = new Mouvement();

    // Connexion pour la transaction
    Connection conn = new ConnectionDB().getConnexion();
    conn.setAutoCommit(false); // Début TRANSACTION

    try {
        //  Vérification date
        if (!verifierDate(a)) {
            DateNotValide ex = new DateNotValide();
            ex.setDaty(a.getDate_limite());
            ex.setNumero_cheque(a.getNumero_cheque());
            throw ex;
        }
        System.out.println("Date valide");

        //  Vérification numéro chèque
        if (!VerifierNum(a)) {
            ChequeNotFoundException ex = new ChequeNotFoundException();
            ex.setNumero_Cheque(a.getNumero_cheque());
            throw ex;
        }
        System.out.println("Chèque existe");

        // Vérification état
        if (!etat(E, cheque)) {
            String etatCheque = ChequeEtatDAO.getChequeAvecEtat(E);
            ChequeEncaisséVoléException ex = new ChequeEncaisséVoléException();
            ex.setNumero_Cheque(a.getNumero_cheque());
            ex.setEtat(etatCheque);
            throw ex;
        }
        System.out.println("Chèque OK pour encaissement");

        //  Vérification montant
        if (!VerifierMontant(mouv, a)) {
            MontantInsuffisantException ex = new MontantInsuffisantException();
            ex.setMontantDemande(a.getMontant());
            ex.setNumero_cheque(a.getNumero_cheque());
            throw ex;
        }
        System.out.println("✅ Solde validé");

       
        // TOUT EST VALIDÉ → TRANSACTION

        // UPDATE CHEQUE_ETAT (OK → ENCAISSÉ)
        String sqlEtat = """
           INSERT INTO ChequeEtat (id_cheque, id_etat, beneficiaire, date_etat)
    VALUES (?,?,?, CURRENT_DATE)
        """;

        try (PreparedStatement ps = conn.prepareStatement(sqlEtat)) {
            ps.setInt(1, cheque.getId_Cheque());
            ps.setInt(2,3);
            ps.setString(3, a.getNom_beneficiaire());
            ps.executeUpdate();
        }

        //  INSERT MOUVEMENT (DEBIT)
        mouv.setNumero_compte(cheque.getNumero_Compte());
        mouv.setType("debit");
        mouv.setMontant(a.getMontant());

        MouvementDAO.save(conn, mouv);

        // COMMIT FINAL
        conn.commit();
        System.out.println(" Chèque encaissé avec succès");

    } catch (Exception ex) {
        conn.rollback(); //  ANNULATION SI ERREUR
        throw ex;
    } finally {
        conn.setAutoCommit(true);
        conn.close();
    }
}

public static void Add(Cheque a,ChequeEtat e) throws Exception{
    ConnectionDB db = new ConnectionDB();
    Connection conn = null;
    try{
        conn=db.getConnexion();
        conn.setAutoCommit(false);
        ChequeDAO.insert(a,conn);
        e.insertIntoEtat(conn,a); 
        conn.commit();
    }catch(Exception ex){
        if(conn!=null){
            conn.rollback();
        }
        throw ex;
    }finally{
        if (conn != null) {
            conn.setAutoCommit(true); // retour mode normal
            conn.close();
        }
    }
    
}
public static void Modify(Cheque a, ChequeEtat e) throws Exception{
    ConnectionDB db = new ConnectionDB();
    Connection conn = null;
    try{
        conn=db.getConnexion();
        conn.setAutoCommit(false);
        ChequeDAO.update(conn,a);
        e.setId_cheque(a.getId_Cheque());
      //  e.insertIntoEtat(conn,a);
        conn.commit();
    }catch(Exception ex){
        if(conn !=null){
            conn.rollback();
        }
        throw ex;
    }finally{
        if(conn!=null){
            conn.setAutoCommit(true);
            conn.close();
        }
    }
}
public static BigDecimal getSolde(String numero_compte) throws Exception {
    BigDecimal sommeDebit = MouvementDAO.getTotalDebit(numero_compte);
    BigDecimal sommeCredit = MouvementDAO.getTotalCredit(numero_compte);
    // solde = crédit - débit
    return sommeCredit.subtract(sommeDebit);

}
public static void main(String[] args) throws Exception {
    BigDecimal solde = getSolde("ACC98765");
    System.out.println(solde);
}
}