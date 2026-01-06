package Servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;

import Model.Mouvement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MouvementServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            // Récupération des paramètres du formulaire avec gestion null
            String numeroCompte = req.getParameter("numeroCompte");
            String type = req.getParameter("type");

            String dateDebutStr = req.getParameter("dateDebut");
            String dateDebutOp = req.getParameter("dateDebutOperator");
            if (dateDebutOp == null || dateDebutOp.isEmpty()) {
                dateDebutOp = ">="; // Valeur par défaut
            }

            String dateFinStr = req.getParameter("dateFin");
            String dateFinOp = req.getParameter("dateFinOperator");
            if (dateFinOp == null || dateFinOp.isEmpty()) {
                dateFinOp = "<="; // Valeur par défaut
            }

            String montantMinStr = req.getParameter("montantMin");
            String montantMinOp = req.getParameter("montantMinOperator");
            if (montantMinOp == null || montantMinOp.isEmpty()) {
                montantMinOp = ">="; // Valeur par défaut
            }

            String montantMaxStr = req.getParameter("montantMax");
            String montantMaxOp = req.getParameter("montantMaxOperator");
            if (montantMaxOp == null || montantMaxOp.isEmpty()) {
                montantMaxOp = "<="; // Valeur par défaut
            }

            // Conversion des valeurs avec gestion d'erreur
            Date dateDebut = null;
            Date dateFin = null;
            BigDecimal montantMin = null;
            BigDecimal montantMax = null;

            try {
                if (dateDebutStr != null && !dateDebutStr.trim().isEmpty()) {
                    dateDebut = Date.valueOf(dateDebutStr);
                }
            } catch (IllegalArgumentException e) {
                System.err.println("Format de date début invalide: " + dateDebutStr);
            }

            try {
                if (dateFinStr != null && !dateFinStr.trim().isEmpty()) {
                    dateFin = Date.valueOf(dateFinStr);
                }
            } catch (IllegalArgumentException e) {
                System.err.println("Format de date fin invalide: " + dateFinStr);
            }

            try {
                if (montantMinStr != null && !montantMinStr.trim().isEmpty()) {
                    montantMin = new BigDecimal(montantMinStr);
                }
            } catch (NumberFormatException e) {
                System.err.println("Format de montant min invalide: " + montantMinStr);
            }

            try {
                if (montantMaxStr != null && !montantMaxStr.trim().isEmpty()) {
                    montantMax = new BigDecimal(montantMaxStr);
                }
            } catch (NumberFormatException e) {
                System.err.println("Format de montant max invalide: " + montantMaxStr);
            }

            // Récupération de tous les mouvements
            ArrayList<Mouvement> tous = Mouvement.findAllMouvement();
            
            // Vérification que la liste n'est pas nulle
            if (tous == null) {
                tous = new ArrayList<>();
            }

            // Filtrage multi-champs
            ArrayList<Mouvement> filtres = Mouvement.searchMouvements(
                    tous,
                    numeroCompte,
                    type,
                    dateDebut, dateDebutOp,
                    dateFin, dateFinOp,
                    montantMin, montantMinOp,
                    montantMax, montantMaxOp
            );

            // Envoi à la JSP
            req.setAttribute("listeMouvements", filtres);
            req.getRequestDispatcher("/WEB-INF/mouv.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la récupération des mouvements: " + e.getMessage());
            req.setAttribute("listeMouvements", new ArrayList<Mouvement>());
            req.getRequestDispatcher("/WEB-INF/mouv.jsp").forward(req, res);
        }
    }

     protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Rediriger POST vers GET
        doGet(req, res);
    }
}
