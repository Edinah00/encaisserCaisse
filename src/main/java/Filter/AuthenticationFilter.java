package Filter;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isLoginPage = path.endsWith("/login");
        boolean isLoginAction = path.endsWith("/authenticate");
        boolean isListePage = path.contains("/liste");

        // Autoriser l'accès aux pages de liste sans authentification
        if (isListePage || isLoginPage || isLoginAction) {
            chain.doFilter(request, response);
            return;
        }

        // Pour toutes les autres pages, vérifier l'authentification
        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}

