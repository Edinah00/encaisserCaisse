package Servlet;

import java.io.IOException;
import DAO.UserDAO;
import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        
        if ("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            res.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            User user = UserDAO.authenticate(username, password);           if (user != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(30 * 60); // 30 minitra

                res.sendRedirect(req.getContextPath() + "/Cheque/liste");
            } else {
                req.setAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
                req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, res);
            }

        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors de la connexion");
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, res);
        }
    }
}