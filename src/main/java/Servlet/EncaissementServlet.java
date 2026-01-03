package Servlet;
import Service.Service;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

import Exception.ChequeEncaisséVoléException;
import Exception.ChequeNotFoundException;
import Exception.DateNotValide;
import Exception.MontantInsuffisantException;
import Model.FormEncaissement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EncaissementServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {
    try {
        // Récupération des paramètres
        String numeroCheque = req.getParameter("numero_cheque");
        String montantStr = req.getParameter("montant");
        String dateLimiteStr = req.getParameter("date_limite");
        String nomBeneficiaire = req.getParameter("nom_beneficiaire");

        BigDecimal montant = (montantStr != null && !montantStr.isEmpty()) ? new BigDecimal(montantStr) : null;
        Date dateLimite = (dateLimiteStr != null && !dateLimiteStr.isEmpty()) ? Date.valueOf(dateLimiteStr) : null;

        FormEncaissement form = new FormEncaissement();
        form.setNumero_cheque(numeroCheque);
        form.setMontant(montant);
        form.setDate_limite(dateLimite);
        form.setNom_beneficiaire(nomBeneficiaire);

        Service EncaissementService = new Service();
        EncaissementService.encaisserCheque(form);

        req.setAttribute("success", "✅ Chèque encaissé avec succès !");
    } catch (ChequeEncaisséVoléException e) {
        req.setAttribute("error", "Chèque " + e.getNumero_Cheque() + " est " + e.getEtat());
    } catch (ChequeNotFoundException e) {
        req.setAttribute("error", "Chèque " + e.getNumero_Cheque() + " introuvable.");
    } catch (DateNotValide e) {
        req.setAttribute("error", "Date limite " + e.getDaty() + " du chèque " + e.getNumero_cheque() + " est dépassée.");
    } catch (MontantInsuffisantException e) {
        req.setAttribute("error", "Solde insuffisant pour encaisser " + e.getMontantDemande() + ".");
    } catch (Exception e) {
        req.setAttribute("error", " Erreur inattendue : " + e.getMessage());
    }

    req.getRequestDispatcher("/WEB-INF/encaissement.jsp").forward(req, res);
}

    @Override
protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {
    // Affiche simplement le formulaire JSP
    req.getRequestDispatcher("/WEB-INF/encaissement.jsp").forward(req, res);
}

}
