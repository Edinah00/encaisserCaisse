package Servlet;

import java.io.IOException;
import java.math.BigDecimal;

import DAO.Service.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CompteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req ,HttpServletResponse res)
    throws ServletException, IOException {
        try {
            String path = req.getRequestURI();

           
    if (path.endsWith("/solde")) {

            String numero_compte = req.getParameter("numero_compte");
            if (numero_compte == null || numero_compte.trim().isEmpty()) {
                res.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                res.setContentType("application/json");
                res.getWriter().write("{\"error\":\"Le numéro de compte est requis\"}");
                return;
            }

            BigDecimal solde = Service.getSolde(numero_compte);

            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");

            // JSON écrit manuellement (sans Gson)
            String json =
                    "{"
                  + "\"numero_compte\":\"" + numero_compte + "\","
                  + "\"solde\":" + solde
                  + "}";

            res.getWriter().write(json);
        }
 else if(path.endsWith("/form")) {
                
                req.getRequestDispatcher("/WEB-INF/formSold.jsp").forward(req, res);
            }
            else {
                throw new ServletException("URL non reconnue : " + path);
            }
        } catch (Exception e) {
            throw new ServletException("Erreur lors de la récupération du solde.", e);
        }
    }
}
