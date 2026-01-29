package Servlet;

import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DAO.ChequeDAO;
import DAO.ChequeEtatDAO;
import DAO.EtatChequeDAO;
import DAO.Service.Service;
import Model.Cheque;
import Model.ChequeEtat;
import Model.EtatCheque;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ChequeStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            String path = req.getRequestURI(); // ChequeServlet/Cheque/delete/12
            String[] parts = path.split("/");
            System.out.println("URI = " + path);

            String idStr = parts[parts.length - 1];
            if (idStr == null || idStr.isEmpty()) {
                throw new ServletException("ID ChequeEtat manquant dans l'URL");
            }
            int id = Integer.parseInt(idStr);

            if (path.contains("/delete/")) {
                ChequeEtat e = new ChequeEtat();
                e.setId_ChequeEtat(id);
                ChequeEtatDAO.findById(e);
                String id_chequeStr = req.getParameter("id_cheque");
                if (id_chequeStr == null || id_chequeStr.isEmpty()) {
                    throw new ServletException("id_cheque manquant dans la requête");
                }
                int id_cheque = Integer.parseInt(id_chequeStr);

                ChequeEtatDAO.remove(e);

                res.sendRedirect(req.getContextPath() + "/Cheque/form/" + id_cheque);

            }

        } catch (Exception e) {
            throw new ServletException("Erreur dans ChequeStatusServlet", e);
        }
    }
protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

    try {
        String path = req.getRequestURI(); 
        String[] parts = path.split("/");
        String lastPart = parts[parts.length - 1]; 

        if (path.contains("/save/")) {
            // Ici lastPart est un ID numérique
            int id_chequeEtat = Integer.parseInt(lastPart);

            // Récupération des paramètres
            String idString2 = req.getParameter("id_etat");
            String dateString = req.getParameter("date_etat");
            String ben = req.getParameter("beneficiaire");
            String idChequeStr = req.getParameter("id_cheque");

            if (idString2 == null || dateString == null || ben == null) {
                throw new ServletException("Paramètres manquants pour la mise à jour du chèque");
            }

            java.sql.Date dateEtat = java.sql.Date.valueOf(dateString);
            int id_etat = Integer.parseInt(idString2);
            int id_Cheque = Integer.parseInt(idChequeStr);

            ChequeEtat etat = new ChequeEtat();
            etat.setId_ChequeEtat(id_chequeEtat);
            etat.setId_cheque(id_Cheque);
            etat.setDaty(dateEtat);
            etat.setId_etat(id_etat);
            etat.setBeneficiaire(ben);

            ChequeEtatDAO.update(etat);
            res.sendRedirect(req.getContextPath() + "/Cheque/form/" + id_Cheque);

        } else if (path.contains("/add")) {
            // Ici pas besoin de parseInt sur "add"
            String idChequeStr = req.getParameter("id_cheque");
            String idEtatStr = req.getParameter("id_etat");
            String dateStr = req.getParameter("date_etat");
            String beneficiaire = req.getParameter("beneficiaire");

            if (idChequeStr == null || idEtatStr == null || dateStr == null || beneficiaire == null) {
                throw new ServletException("Paramètres manquants pour l'ajout d'un nouvel état");
            }

            int idCheque = Integer.parseInt(idChequeStr);
            int idEtat = Integer.parseInt(idEtatStr);
            java.sql.Date dateEtat = java.sql.Date.valueOf(dateStr);

            ChequeEtat nouvelEtat = new ChequeEtat();
            nouvelEtat.setId_cheque(idCheque);
            nouvelEtat.setId_etat(idEtat);
            nouvelEtat.setDaty(dateEtat);
            nouvelEtat.setBeneficiaire(beneficiaire);

            Cheque cheque = new Cheque();
            cheque.setId_Cheque(idCheque);
            ChequeDAO.findById(cheque);

            nouvelEtat.insertIntoEtat(cheque);

            res.sendRedirect(req.getContextPath() + "/Cheque/form/" + idCheque);
        }

    } catch (Exception e) {
        e.printStackTrace();
        throw new ServletException("Erreur dans ChequeStatusServlet", e);
    }
}


}