package Servlet;

import java.io.IOException;
import java.math.BigDecimal;

import Service.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CompteServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        // Configuration CORS pour permettre les appels depuis PHP
        res.setHeader("Access-Control-Allow-Origin", "*");
        res.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
        res.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
        
        try {
            String path = req.getRequestURI();

            if (path.endsWith("/solde")) {
                // Récupération du paramètre
                String numero_compte = req.getParameter("numero_compte");
                
                // Validation du paramètre
                if (numero_compte == null || numero_compte.trim().isEmpty()) {
                    res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    res.setContentType("application/json");
                    res.setCharacterEncoding("UTF-8");
                    res.getWriter().write("{\"error\":\"Le numéro de compte est requis\"}");
                    return;
                }

                // Récupération du solde
                BigDecimal solde = Service.getSolde(numero_compte);
                
                // Si le solde est null, le compte n'existe pas
                if (solde == null) {
                    res.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    res.setContentType("application/json");
                    res.setCharacterEncoding("UTF-8");
                    res.getWriter().write("{\"error\":\"Compte non trouvé\"}");
                    return;
                }

                // Configuration de la réponse
                res.setStatus(HttpServletResponse.SC_OK);
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");

                // JSON écrit manuellement (sans Gson)
                String json = "{"
                        + "\"numero_compte\":\"" + numero_compte + "\","
                        + "\"solde\":" + solde
                        + "}";

                res.getWriter().write(json);
                
            } else if (path.endsWith("/form")) {
                // Affichage du formulaire JSP
                req.getRequestDispatcher("/WEB-INF/formSold.php").forward(req, res);
                
            } else {
                // URL non reconnue
                res.setStatus(HttpServletResponse.SC_NOT_FOUND);
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.getWriter().write("{\"error\":\"URL non reconnue : " + path + "\"}");
            }
            
        } catch (Exception e) {
            // Gestion des erreurs
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            
            String errorMessage = e.getMessage() != null ? e.getMessage() : "Erreur interne du serveur";
            res.getWriter().write("{\"error\":\"" + errorMessage.replace("\"", "\\\"") + "\"}");
            
            // Log de l'erreur pour le débogage
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Gestion des requêtes OPTIONS pour CORS (preflight)
        res.setHeader("Access-Control-Allow-Origin", "*");
        res.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
        res.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
        res.setStatus(HttpServletResponse.SC_OK);
    }
}