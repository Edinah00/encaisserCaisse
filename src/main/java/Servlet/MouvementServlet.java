package Servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;

import Model.Mouvement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MouvementServlet/liste")
public class MouvementServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            // Récupération des paramètres du formulaire
            String numeroCompte = req.getParameter("numeroCompte");
            String type = req.getParameter("type");

            String dateDebutStr = req.getParameter("dateDebut");
            String dateDebutOp = req.getParameter("dateDebutOperator");

            String dateFinStr = req.getParameter("dateFin");
            String dateFinOp = req.getParameter("dateFinOperator");

            String montantMinStr = req.getParameter("montantMin");
            String montantMinOp = req.getParameter("montantMinOperator");

            String montantMaxStr = req.getParameter("montantMax");
            String montantMaxOp = req.getParameter("montantMaxOperator");

            // Conversion des valeurs
            Date dateDebut = (dateDebutStr != null && !dateDebutStr.isEmpty()) ? Date.valueOf(dateDebutStr) : null;
            Date dateFin = (dateFinStr != null && !dateFinStr.isEmpty()) ? Date.valueOf(dateFinStr) : null;

            BigDecimal montantMin = (montantMinStr != null && !montantMinStr.isEmpty()) ? new BigDecimal(montantMinStr) : null;
            BigDecimal montantMax = (montantMaxStr != null && !montantMaxStr.isEmpty()) ? new BigDecimal(montantMaxStr) : null;

            // Récupération de tous les mouvements
            ArrayList<Mouvement> tous = Mouvement.findAllMouvement();

            // Filtrage multi‑champs
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
            throw new ServletException("Erreur dans MouvementServlet", e);
        }
    }
}
