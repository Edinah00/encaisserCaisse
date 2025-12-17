package Servlet;

import java.io.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Service.Service;
import DAO.ChequeDAO;
import DAO.ChequeEtatDAO;
import DAO.EtatChequeDAO;
import Model.Cheque;
import Model.ChequeEtat;
import Model.EtatCheque;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ChequeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            // fangalana anle URL demandée
            String path = req.getRequestURI(); // ChequeServlet/Cheque/delete/12
            String[] parts = path.split("/");
            String idStr = parts[parts.length - 1];
            if (path.endsWith("/liste")) {
                // Affichage de la liste
                ArrayList<Cheque> listeCheques = ChequeDAO.findAllCheque();
                req.setAttribute("listeCheques", listeCheques);
                req.getRequestDispatcher("/WEB-INF/liste.jsp").forward(req, res);

            } else if (path.contains("/delete/")) {
                // Extraction de l'ID du chemin
                int id = Integer.parseInt(idStr); // cqsteoo

                // Création de l'objet Cheque et suppression
                Cheque cheque = new Cheque();
                cheque.setId_Cheque(id);
                ChequeDAO.remove(cheque);

               
                // refa vofafa redirection vers la liste
                res.sendRedirect(req.getContextPath() + "/Cheque/liste");
            } else if (path.contains("form")) {
                // take listes etats , izy retra2
                ArrayList<EtatCheque> listeEtat = EtatChequeDAO.getAllEtat();
                req.setAttribute("listeEtat", listeEtat);
                
                // rah i modif de maka anle id sady maka anle Cheque
                if (path.contains("/form/") && idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    Cheque cheque = new Cheque();
                    cheque.setId_Cheque(id);
                    ChequeDAO.findById(cheque);

                    ChequeEtat chequeEtat = new ChequeEtat();
                    chequeEtat.setId_cheque(id);
                    
                   ArrayList<ChequeEtat> listeChequeEtat = ChequeEtatDAO.findAllChequeEtatByCheque(chequeEtat);

                    req.setAttribute("chequeEtat", listeChequeEtat);
                    req.setAttribute("cheque", cheque);
                }
               

                req.getRequestDispatcher("/WEB-INF/form.jsp").forward(req, res);
            }

        } catch (Exception e) {
            throw new ServletException("Erreur dans ChequeServlet", e);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String path = req.getRequestURI(); // /Cheque/add

            if (path.endsWith("/add")) {

                // maka anle champs champs
                String idStr = req.getParameter("id_cheque");
                String numero = req.getParameter("numero");
                String compte = req.getParameter("compte");
                String dateLim = req.getParameter("date_limite");
                String idEtatStr = req.getParameter("id_etat");

                // Conversions
                java.sql.Date dateLimite = java.sql.Date.valueOf(dateLim);
                int idEtat = Integer.parseInt(idEtatStr);

                ChequeEtat etat = new ChequeEtat();
                etat.setId_etat(idEtat);

                // mi ajoute
                if (idStr == null || idStr.isEmpty()) {

                    Cheque cheque = new Cheque(numero, compte, dateLimite);
                    Service.Add(cheque, etat);

                }
                // mi edit
                else {

                    int idCheque = Integer.parseInt(idStr);

                    Cheque cheque = new Cheque();
                    cheque.setId_Cheque(idCheque);
                    cheque.setNumero_Cheque(numero);
                    cheque.setNumero_Compte(compte);
                    cheque.setDate_limite(dateLimite);

                    Service.Modify(cheque, etat);
                }

                // redirection
                res.sendRedirect(req.getContextPath() + "/Cheque/liste");
            }

        } catch (Exception ex) {
            throw new ServletException("Erreur dans ChequeServlet DoPost", ex);
        }
    }

}
